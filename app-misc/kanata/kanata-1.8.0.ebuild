# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aho-corasick@1.1.3
	anstream@0.6.17
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.6
	anstyle@1.0.9
	anyhow@1.0.91
	arboard@3.4.1
	arraydeque@0.5.1
	atomic-polyfill@1.0.3
	autocfg@1.4.0
	backtrace-ext@0.2.1
	backtrace@0.3.74
	bitflags@1.3.2
	bitflags@2.6.0
	bitvec@1.0.1
	block2@0.5.1
	bumpalo@3.16.0
	bytemuck@1.19.0
	byteorder-lite@0.1.0
	byteorder@1.5.0
	cc@1.1.31
	cfg-if@1.0.0
	clap@4.5.20
	clap_builder@4.5.20
	clap_derive@4.5.18
	clap_lex@0.7.2
	clipboard-win@5.4.0
	colorchoice@1.0.3
	core-foundation-sys@0.8.7
	core-foundation@0.10.0
	core-foundation@0.9.4
	core-graphics-types@0.1.3
	core-graphics-types@0.2.0
	core-graphics@0.23.2
	core-graphics@0.24.0
	crc32fast@1.4.2
	critical-section@1.2.0
	deranged@0.3.11
	dirs-sys@0.4.1
	dirs@5.0.1
	either@1.13.0
	embed-resource@2.5.0
	encode_unicode@0.3.6
	endian-type@0.1.2
	equivalent@1.0.1
	errno@0.3.10
	error-code@3.3.1
	evdev@0.12.2
	fdeflate@0.3.7
	flate2@1.0.35
	foreign-types-macros@0.2.3
	foreign-types-shared@0.3.1
	foreign-types@0.5.0
	funty@2.0.0
	gethostname@0.4.3
	getrandom@0.2.15
	gimli@0.31.1
	hash32@0.2.1
	hashbrown@0.15.0
	heapless@0.7.17
	heck@0.5.0
	hermit-abi@0.4.0
	image@0.25.5
	indexmap@2.6.0
	indoc@2.0.5
	inotify-sys@0.1.5
	inotify@0.10.2
	instant@0.1.13
	interception-sys@0.1.3
	is-docker@0.2.0
	is-terminal@0.4.13
	is-wsl@0.4.0
	is_ci@1.2.0
	is_terminal_polyfill@1.70.1
	itertools@0.12.1
	itoa@1.0.11
	jobserver@0.1.32
	jpeg-decoder@0.3.1
	js-sys@0.3.72
	kanata-interception@0.3.0
	kanata-keyberon-macros@0.2.0
	kanata-keyberon@0.180.1
	kanata-parser@0.180.1
	kanata-tcp-protocol@0.180.1
	karabiner-driverkit@0.1.4
	lazy_static@1.5.0
	libc@0.2.161
	libredox@0.1.3
	linux-raw-sys@0.4.15
	lock_api@0.4.12
	log@0.4.22
	malloc_buf@0.0.6
	memchr@2.7.4
	memoffset@0.6.5
	memoffset@0.7.1
	miette-derive@5.10.0
	miette@5.10.0
	miniz_oxide@0.8.0
	mio@0.8.11
	muldiv@0.2.1
	muldiv@1.0.1
	native-windows-gui@1.0.13
	nibble_vec@0.1.0
	nix@0.23.2
	nix@0.26.4
	num-conv@0.1.0
	num-traits@0.2.19
	num_enum@0.6.1
	num_enum_derive@0.6.1
	num_threads@0.1.7
	objc-sys@0.3.5
	objc2-app-kit@0.2.2
	objc2-core-data@0.2.2
	objc2-core-image@0.2.2
	objc2-encode@4.1.0
	objc2-foundation@0.2.2
	objc2-metal@0.2.2
	objc2-quartz-core@0.2.2
	objc2@0.5.2
	objc@0.2.7
	object@0.36.5
	once_cell@1.20.2
	open@5.3.0
	option-ext@0.2.0
	os_info@3.8.2
	os_pipe@1.2.1
	owo-colors@3.5.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	pathdiff@0.2.2
	patricia_tree@0.8.0
	pin-utils@0.1.0
	png@0.17.16
	powerfmt@0.2.0
	proc-macro-crate@1.3.1
	proc-macro2@1.0.89
	quote@1.0.37
	radium@0.7.0
	radix_trie@0.2.1
	redox_syscall@0.5.7
	redox_users@0.4.6
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.1
	rustc-demangle@0.1.24
	rustc-hash@1.1.0
	rustc_version@0.4.1
	rustix@0.38.44
	ryu@1.0.18
	scopeguard@1.2.0
	sd-notify@0.4.3
	semver@1.0.23
	serde@1.0.213
	serde_derive@1.0.213
	serde_json@1.0.132
	serde_spanned@0.6.8
	shlex@1.3.0
	signal-hook-registry@1.4.2
	signal-hook@0.3.17
	simd-adler32@0.3.7
	simplelog@0.12.2
	smallvec@1.13.2
	smawk@0.3.2
	spin@0.9.8
	stable_deref_trait@1.2.0
	strip-ansi-escapes@0.2.0
	strsim@0.11.1
	supports-color@2.1.0
	supports-hyperlinks@2.1.0
	supports-unicode@2.1.0
	syn@2.0.85
	tap@1.0.1
	termcolor@1.4.1
	terminal_size@0.1.17
	textwrap@0.15.2
	thiserror-impl@1.0.65
	thiserror@1.0.65
	tiff@0.9.1
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.19.15
	toml_edit@0.22.22
	unicode-ident@1.0.13
	unicode-linebreak@0.1.5
	unicode-width@0.1.14
	utf8parse@0.2.2
	vswhom-sys@0.1.2
	vswhom@0.1.0
	vte@0.11.1
	vte_generate_state_changes@0.1.2
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.95
	wasm-bindgen-macro-support@0.2.95
	wasm-bindgen-macro@0.2.95
	wasm-bindgen-shared@0.2.95
	wasm-bindgen@0.2.95
	web-sys@0.3.72
	weezl@0.1.8
	widestring@1.1.0
	win_dbg_logger@0.1.0
	winapi-build@0.1.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.6
	winnow@0.5.40
	winnow@0.6.20
	winreg@0.52.0
	wyz@0.5.1
	x11rb-protocol@0.13.1
	x11rb@0.13.1
"

inherit cargo

DESCRIPTION="Multi-layer keyboard customization"
HOMEPAGE="https://github.com/jtroo/kanata"
SRC_URI="
	https://github.com/jtroo/kanata/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="LGPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD Boost-1.0 ISC LGPL-3 MIT MPL-2.0 Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"

IUSE="cmd"

QA_FLAGS_IGNORED="usr/bin/kanata"

src_configure() {
	local myfeatures=(
		$(usev cmd)
	)
	cargo_src_configure
}
