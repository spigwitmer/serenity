#!/usr/bin/env -S bash ../.port_include.sh
port=libbacktrace
commit=4f57c999716847e45505b3df170150876b545088
version="${commit}"
useconfigure="true"
configopts="--enable-shared --enable-host-shared"
files="https://github.com/ianlancetaylor/libbacktrace/archive/${commit}.zip libbacktrace-${version}.zip 106fd81f48b1dfe74cad4dd4b80a991e43f26bcb2852cbc9bdd4083e25d71ed0"
auth_type="sha256"
