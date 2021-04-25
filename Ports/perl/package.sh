#!/usr/bin/env -S bash ../.port_include.sh
port=perl
version=5.32.1
useconfigure=true
configscript=configure.gnu
files="https://www.cpan.org/src/5.0/perl-5.32.1.tar.gz perl-5.32.1.tar.gz 03b693901cd8ae807231b1787798cf1f2e0b8a56218d07b7da44f784a7caeb2c"
auth_type="sha256"

configure() {
    run env ./"$configscript" -de -Dcc=${SERENITY_ARCH}-pc-serenity-gcc -Donlyextensions= -Dusedl=n
}
