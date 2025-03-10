/*
 * Copyright (c) 2020, Ali Mohammad Pur <mpfard@serenityos.org>
 *
 * SPDX-License-Identifier: BSD-2-Clause
 */

#include <AK/Debug.h>
#include <LibCrypto/ASN1/DER.h>
#include <LibCrypto/PK/Code/EMSA_PSS.h>
#include <LibTLS/TLSv12.h>

namespace TLS {

bool TLSv12::expand_key()
{
    u8 key[192]; // soooooooo many constants
    auto key_buffer = Bytes { key, sizeof(key) };

    auto is_aead = this->is_aead();

    if (m_context.master_key.size() == 0) {
        dbgln("expand_key() with empty master key");
        return false;
    }

    auto key_size = key_length();
    auto mac_size = mac_length();
    auto iv_size = iv_length();

    pseudorandom_function(
        key_buffer,
        m_context.master_key,
        (const u8*)"key expansion", 13,
        ReadonlyBytes { m_context.remote_random, sizeof(m_context.remote_random) },
        ReadonlyBytes { m_context.local_random, sizeof(m_context.local_random) });

    size_t offset = 0;
    if (is_aead) {
        iv_size = 4; // Explicit IV size.
    } else {
        memcpy(m_context.crypto.local_mac, key + offset, mac_size);
        offset += mac_size;
        memcpy(m_context.crypto.remote_mac, key + offset, mac_size);
        offset += mac_size;
    }

    auto client_key = key + offset;
    offset += key_size;
    auto server_key = key + offset;
    offset += key_size;
    auto client_iv = key + offset;
    offset += iv_size;
    auto server_iv = key + offset;
    offset += iv_size;

    if constexpr (TLS_DEBUG) {
        dbgln("client key");
        print_buffer(client_key, key_size);
        dbgln("server key");
        print_buffer(server_key, key_size);
        dbgln("client iv");
        print_buffer(client_iv, iv_size);
        dbgln("server iv");
        print_buffer(server_iv, iv_size);
        if (!is_aead) {
            dbgln("client mac key");
            print_buffer(m_context.crypto.local_mac, mac_size);
            dbgln("server mac key");
            print_buffer(m_context.crypto.remote_mac, mac_size);
        }
    }

    if (is_aead) {
        memcpy(m_context.crypto.local_aead_iv, client_iv, iv_size);
        memcpy(m_context.crypto.remote_aead_iv, server_iv, iv_size);

        m_aes_local.gcm = make<Crypto::Cipher::AESCipher::GCMMode>(ReadonlyBytes { client_key, key_size }, key_size * 8, Crypto::Cipher::Intent::Encryption, Crypto::Cipher::PaddingMode::RFC5246);
        m_aes_remote.gcm = make<Crypto::Cipher::AESCipher::GCMMode>(ReadonlyBytes { server_key, key_size }, key_size * 8, Crypto::Cipher::Intent::Decryption, Crypto::Cipher::PaddingMode::RFC5246);
    } else {
        memcpy(m_context.crypto.local_iv, client_iv, iv_size);
        memcpy(m_context.crypto.remote_iv, server_iv, iv_size);

        m_aes_local.cbc = make<Crypto::Cipher::AESCipher::CBCMode>(ReadonlyBytes { client_key, key_size }, key_size * 8, Crypto::Cipher::Intent::Encryption, Crypto::Cipher::PaddingMode::RFC5246);
        m_aes_remote.cbc = make<Crypto::Cipher::AESCipher::CBCMode>(ReadonlyBytes { server_key, key_size }, key_size * 8, Crypto::Cipher::Intent::Decryption, Crypto::Cipher::PaddingMode::RFC5246);
    }

    m_context.crypto.created = 1;

    return true;
}

void TLSv12::pseudorandom_function(Bytes output, ReadonlyBytes secret, const u8* label, size_t label_length, ReadonlyBytes seed, ReadonlyBytes seed_b)
{
    if (!secret.size()) {
        dbgln("null secret");
        return;
    }

    // RFC 5246: "In this section, we define one PRF, based on HMAC.  This PRF with the
    //            SHA-256 hash function is used for all cipher suites defined in this
    //            document and in TLS documents published prior to this document when
    //            TLS 1.2 is negotiated."
    // Apparently this PRF _always_ uses SHA256

    auto append_label_seed = [&](auto& hmac) {
        hmac.update(label, label_length);
        hmac.update(seed);
        if (seed_b.size() > 0)
            hmac.update(seed_b);
    };

    Crypto::Authentication::HMAC<Crypto::Hash::SHA256> hmac(secret);
    append_label_seed(hmac);

    constexpr auto digest_size = hmac.digest_size();
    u8 digest[digest_size];
    auto digest_0 = Bytes { digest, digest_size };

    digest_0.overwrite(0, hmac.digest().immutable_data(), digest_size);

    size_t index = 0;
    while (index < output.size()) {
        hmac.update(digest_0);
        append_label_seed(hmac);
        auto digest_1 = hmac.digest();

        auto copy_size = min(digest_size, output.size() - index);

        output.overwrite(index, digest_1.immutable_data(), copy_size);
        index += copy_size;

        digest_0.overwrite(0, hmac.process(digest_0).immutable_data(), digest_size);
    }
}

bool TLSv12::compute_master_secret(size_t length)
{
    if (m_context.premaster_key.size() == 0 || length < 48) {
        dbgln("there's no way I can make a master secret like this");
        dbgln("I'd like to talk to your manager about this length of {}", length);
        return false;
    }

    m_context.master_key.clear();
    m_context.master_key.grow(length);

    pseudorandom_function(
        m_context.master_key,
        m_context.premaster_key,
        (const u8*)"master secret", 13,
        ReadonlyBytes { m_context.local_random, sizeof(m_context.local_random) },
        ReadonlyBytes { m_context.remote_random, sizeof(m_context.remote_random) });

    m_context.premaster_key.clear();
    if constexpr (TLS_DEBUG) {
        dbgln("master key:");
        print_buffer(m_context.master_key);
    }
    expand_key();
    return true;
}

ByteBuffer TLSv12::build_certificate()
{
    PacketBuilder builder { MessageType::Handshake, m_context.options.version };

    Vector<const Certificate*> certificates;
    Vector<Certificate>* local_certificates = nullptr;

    if (m_context.is_server) {
        dbgln("Unsupported: Server mode");
        VERIFY_NOT_REACHED();
    } else {
        local_certificates = &m_context.client_certificates;
    }

    constexpr size_t der_length_delta = 3;
    constexpr size_t certificate_vector_header_size = 3;

    size_t total_certificate_size = 0;

    for (size_t i = 0; i < local_certificates->size(); ++i) {
        auto& certificate = local_certificates->at(i);
        if (!certificate.der.is_empty()) {
            total_certificate_size += certificate.der.size() + der_length_delta;

            // FIXME: Check for and respond with only the requested certificate types.
            if (true) {
                certificates.append(&certificate);
            }
        }
    }

    builder.append((u8)HandshakeType::CertificateMessage);

    if (!total_certificate_size) {
        dbgln_if(TLS_DEBUG, "No certificates, sending empty certificate message");
        builder.append_u24(certificate_vector_header_size);
        builder.append_u24(total_certificate_size);
    } else {
        builder.append_u24(total_certificate_size + certificate_vector_header_size); // 3 bytes for header
        builder.append_u24(total_certificate_size);

        for (auto& certificate : certificates) {
            if (!certificate->der.is_empty()) {
                builder.append_u24(certificate->der.size());
                builder.append(certificate->der.bytes());
            }
        }
    }
    auto packet = builder.build();
    update_packet(packet);
    return packet;
}

ByteBuffer TLSv12::build_change_cipher_spec()
{
    PacketBuilder builder { MessageType::ChangeCipher, m_context.options.version, 64 };
    builder.append((u8)1);
    auto packet = builder.build();
    update_packet(packet);
    m_context.local_sequence_number = 0;
    return packet;
}

ByteBuffer TLSv12::build_server_key_exchange()
{
    dbgln("FIXME: build_server_key_exchange");
    return {};
}

ByteBuffer TLSv12::build_client_key_exchange()
{
    PacketBuilder builder { MessageType::Handshake, m_context.options.version };
    builder.append((u8)HandshakeType::ClientKeyExchange);
    build_random(builder);

    m_context.connection_status = ConnectionStatus::KeyExchange;

    auto packet = builder.build();

    update_packet(packet);

    return packet;
}

ssize_t TLSv12::handle_server_key_exchange(ReadonlyBytes)
{
    dbgln("FIXME: parse_server_key_exchange");
    return 0;
}

ssize_t TLSv12::handle_verify(ReadonlyBytes)
{
    dbgln("FIXME: parse_verify");
    return 0;
}

}
