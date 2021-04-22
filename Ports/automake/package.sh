#!/usr/bin/env -S bash ../.port_include.sh
port=automake
version=1.16.3
useconfigure=true
files="https://ftpmirror.gnu.org/gnu/automake/automake-${version}.tar.gz automake-${version}.tar.gz
https://ftpmirror.gnu.org/gnu/automake/automake-${version}.tar.gz.sig automake-${version}.tar.gz.sig
https://ftpmirror.gnu.org/gnu/gnu-keyring.gpg gnu-keyring.gpg"
auth_type="sig"
auth_opts="--keyring ./gnu-keyring.gpg automake-${version}.tar.gz.sig"
