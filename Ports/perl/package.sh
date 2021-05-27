#!/usr/bin/env -S bash ../.port_include.sh
#
#  http://arsv.github.io/perl-cross/usage.html

port=perl
version=5.32.1
crossversion=1.3.5
useconfigure=true
files="https://www.cpan.org/src/5.0/perl-${version}.tar.gz perl-${version}.tar.gz
https://github.com/arsv/perl-cross/releases/download/${crossversion}/perl-cross-${crossversion}.tar.gz perl-cross-${crossversion}.tar.gz"

post_fetch() {	
	run_nocd rsync -av "perl-cross-${crossversion}/" "perl-${version}"
}

configure() {
	chmod +x "$workdir"/configure

	run ./configure \
		-Dosname=serenity \
		--target="${SERENITY_ARCH}-pc-serenity" \
		--targetarch="${SERENITY_ARCH}-pc-serenity" \
		--target-tools-prefix="${SERENITY_ARCH}-pc-serenity-" \
		--sysroot="${SERENITY_BUILD_DIR}/Root" \
		--disable-mod=cpan/Unicode-Normalize \
		-Ud_sockaddr_in6 \
		-Ud_drand48proto \
		-Udrand48_r_proto \
		-Ud_drand48_r \
		-Ud_drand48 \
		-Udrand48 \
		-Drandfunc='random' \
		-Dd_nanosleep \
		-Dinc_version_list=none \
		-Duseshrplib \
		-Dusethreads
			#--include-stdint=yes \
			#-Dbyteorder=1234 \
			#-U d_nanosleep
}

build() {
	run make CFLAGS="-DPERL_CORE=1" LDFLAGS="-lm -lcore -lcrypt -lpthread -ldl -lc" -j$(nproc)
}

post_install() {
    run ln -s perl5/5.32.1/i686-serenity/CORE/libperl.so ${SERENITY_BUILD_DIR}/Root/usr/lib/libperl.so
}
