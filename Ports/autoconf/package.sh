#!/usr/bin/env -S bash ../.port_include.sh
port=autoconf
version=2.71
useconfigure=true
files="https://ftpmirror.gnu.org/gnu/autoconf/autoconf-${version}.tar.gz autoconf-${version}.tar.gz
https://ftpmirror.gnu.org/gnu/autoconf/autoconf-${version}.tar.gz.sig autoconf-${version}.tar.gz.sig
https://ftpmirror.gnu.org/gnu/gnu-keyring.gpg gnu-keyring.gpg"
auth_type="sig"
auth_opts="--keyring ./gnu-keyring.gpg autoconf-${version}.tar.gz.sig"
