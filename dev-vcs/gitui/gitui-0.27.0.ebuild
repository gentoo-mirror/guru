# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.4

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aead@0.5.2
	aes-gcm@0.10.3
	aes@0.8.4
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.21
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.18
	anstyle-parse@0.2.6
	anstyle-query@1.1.2
	anstyle-wincon@3.0.6
	anstyle@1.0.10
	anyhow@1.0.95
	arc-swap@1.7.1
	arrayvec@0.7.6
	autocfg@1.4.0
	backtrace@0.3.74
	base16ct@0.2.0
	base64@0.21.7
	base64ct@1.6.0
	bcrypt-pbkdf@0.10.0
	bincode@1.3.3
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@1.3.2
	bitflags@2.7.0
	block-buffer@0.10.4
	block-padding@0.3.3
	blowfish@0.9.1
	bstr@1.11.3
	bugreport@0.5.1
	bumpalo@3.16.0
	bwrap@1.3.0
	byteorder@1.5.0
	bytesize@1.3.0
	cassowary@0.3.0
	castaway@0.2.3
	cbc@0.1.2
	cc@1.2.7
	cfg-if@1.0.0
	chacha20@0.9.1
	chrono@0.4.39
	cipher@0.4.4
	clap@4.5.26
	clap_builder@4.5.26
	clap_lex@0.7.4
	clru@0.6.2
	cmake@0.1.52
	colorchoice@1.0.3
	compact_str@0.8.1
	const-oid@0.9.6
	core-foundation-sys@0.8.7
	cpufeatures@0.2.16
	crc32fast@1.4.2
	crossbeam-channel@0.5.14
	crossbeam-deque@0.8.6
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.21
	crossterm@0.28.1
	crossterm_winapi@0.9.1
	crypto-bigint@0.5.5
	crypto-common@0.1.6
	ctr@0.9.2
	curve25519-dalek-derive@0.1.1
	curve25519-dalek@4.1.3
	darling@0.20.10
	darling_core@0.20.10
	darling_macro@0.20.10
	der@0.7.9
	deranged@0.3.11
	diff@0.1.13
	digest@0.10.7
	dirs-sys@0.4.1
	dirs@5.0.1
	displaydoc@0.2.5
	dunce@1.0.5
	easy-cast@0.5.3
	ecdsa@0.16.9
	ed25519-dalek@2.1.1
	ed25519@2.2.3
	either@1.13.0
	elliptic-curve@0.13.8
	env_filter@0.1.3
	env_home@0.1.0
	env_logger@0.11.6
	equivalent@1.0.1
	errno@0.3.10
	fancy-regex@0.11.0
	faster-hex@0.9.0
	fastrand@2.3.0
	ff@0.13.0
	fiat-crypto@0.2.9
	filetime@0.2.25
	flate2@1.0.35
	fnv@1.0.7
	foldhash@0.1.4
	form_urlencoded@1.2.1
	fsevent-sys@4.1.0
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	fuzzy-matcher@0.3.7
	generic-array@0.14.7
	getrandom@0.2.15
	gh-emoji@1.0.8
	ghash@0.5.1
	gimli@0.31.1
	git-version-macro@0.3.9
	git-version@0.3.9
	git2@0.20.0
	gix-actor@0.33.1
	gix-bitmap@0.2.13
	gix-chunk@0.4.10
	gix-command@0.4.0
	gix-commitgraph@0.25.1
	gix-config-value@0.14.10
	gix-config@0.42.0
	gix-date@0.9.3
	gix-diff@0.49.0
	gix-discover@0.37.0
	gix-features@0.39.1
	gix-fs@0.12.1
	gix-glob@0.17.1
	gix-hash@0.15.1
	gix-hashtable@0.6.0
	gix-index@0.37.0
	gix-lock@15.0.1
	gix-object@0.46.1
	gix-odb@0.66.0
	gix-pack@0.56.0
	gix-packetline@0.18.2
	gix-path@0.10.13
	gix-protocol@0.47.0
	gix-quote@0.4.14
	gix-ref@0.49.1
	gix-refspec@0.27.0
	gix-revision@0.31.1
	gix-revwalk@0.17.0
	gix-sec@0.10.10
	gix-shallow@0.1.0
	gix-tempfile@15.0.0
	gix-trace@0.1.11
	gix-transport@0.44.0
	gix-traverse@0.43.1
	gix-url@0.28.2
	gix-utils@0.1.13
	gix-validate@0.9.2
	gix@0.69.1
	group@0.13.0
	hashbrown@0.14.5
	hashbrown@0.15.2
	heck@0.5.0
	hmac@0.12.1
	home@0.5.11
	humantime@2.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	icu_collections@1.5.0
	icu_locid@1.5.0
	icu_locid_transform@1.5.0
	icu_locid_transform_data@1.5.0
	icu_normalizer@1.5.0
	icu_normalizer_data@1.5.0
	icu_properties@1.5.1
	icu_properties_data@1.5.0
	icu_provider@1.5.0
	icu_provider_macros@1.5.0
	ident_case@1.0.1
	idna@1.0.3
	idna_adapter@1.2.0
	indexmap@2.7.0
	indoc@2.0.5
	inotify-sys@0.1.5
	inotify@0.11.0
	inout@0.1.3
	instability@0.3.6
	is_terminal_polyfill@1.70.1
	itertools@0.13.0
	itertools@0.14.0
	itoa@1.0.14
	jiff-tzdb-platform@0.1.1
	jiff-tzdb@0.1.1
	jiff@0.1.21
	jobserver@0.1.32
	js-sys@0.3.76
	kqueue-sys@1.0.4
	kqueue@1.0.8
	lazy_static@1.5.0
	libc@0.2.169
	libgit2-sys@0.18.0+1.9.0
	libm@0.2.11
	libredox@0.1.3
	libssh2-sys@0.3.0
	libz-ng-sys@1.1.21
	libz-sys@1.1.21
	linux-raw-sys@0.4.15
	litemap@0.7.4
	lock_api@0.4.12
	log@0.4.22
	lru@0.12.5
	maybe-async@0.2.10
	memchr@2.7.4
	memmap2@0.9.5
	miniz_oxide@0.8.2
	mio@1.0.3
	notify-debouncer-mini@0.6.0
	notify-types@2.0.0
	notify@8.0.0
	ntapi@0.4.1
	num-bigint-dig@0.8.4
	num-conv@0.1.0
	num-integer@0.1.46
	num-iter@0.1.45
	num-traits@0.2.19
	object@0.36.7
	once_cell@1.20.2
	onig@6.4.0
	onig_sys@69.8.1
	opaque-debug@0.3.1
	openssl-probe@0.1.5
	openssl-src@300.4.1+3.4.0
	openssl-sys@0.9.104
	option-ext@0.2.0
	p256@0.13.2
	p384@0.13.0
	p521@0.13.3
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	paste@1.0.15
	pbkdf2@0.12.2
	pem-rfc7468@0.7.0
	percent-encoding@2.3.1
	phf@0.11.3
	phf_shared@0.11.3
	pin-project-lite@0.2.16
	pin-utils@0.1.0
	pkcs1@0.7.5
	pkcs8@0.10.2
	pkg-config@0.3.31
	poly1305@0.8.0
	polyval@0.6.2
	portable-atomic-util@0.2.4
	portable-atomic@1.10.0
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	pretty_assertions@1.4.1
	primeorder@0.13.6
	proc-macro2@1.0.92
	prodash@29.0.0
	quote@1.0.38
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	ratatui@0.29.0
	rayon-core@1.12.1
	rayon@1.10.0
	redox_syscall@0.5.8
	redox_users@0.4.6
	regex-automata@0.4.9
	regex-syntax@0.8.5
	regex@1.11.1
	rfc6979@0.4.0
	ron@0.8.1
	rsa@0.9.7
	rustc-demangle@0.1.24
	rustc_version@0.4.1
	rustix@0.38.43
	rustversion@1.0.19
	ryu@1.0.18
	same-file@1.0.6
	scc@2.3.0
	scopeguard@1.2.0
	sdd@3.0.5
	sec1@0.7.3
	semver@1.0.24
	serde@1.0.217
	serde_derive@1.0.217
	serde_json@1.0.135
	serial_test@3.2.0
	serial_test_derive@3.2.0
	sha1-asm@0.5.3
	sha1@0.10.6
	sha1_smol@1.0.1
	sha2@0.10.8
	shell-escape@0.1.5
	shell-words@1.1.0
	shellexpand@3.1.0
	shlex@1.3.0
	signal-hook-mio@0.2.4
	signal-hook-registry@1.4.2
	signal-hook@0.3.17
	signature@2.2.0
	simplelog@0.12.2
	siphasher@1.0.1
	slab@0.4.9
	smallvec@1.13.2
	spin@0.9.8
	spki@0.7.3
	ssh-cipher@0.2.0
	ssh-encoding@0.2.0
	ssh-key@0.6.7
	stable_deref_trait@1.2.0
	static_assertions@1.1.0
	strsim@0.11.1
	struct-patch-derive@0.8.7
	struct-patch@0.8.7
	strum@0.26.3
	strum_macros@0.26.4
	subtle@2.6.1
	syn@2.0.96
	synstructure@0.13.1
	syntect@5.2.0
	sysinfo@0.33.1
	tempfile@3.15.0
	thiserror-impl@1.0.69
	thiserror-impl@2.0.11
	thiserror@1.0.69
	thiserror@2.0.11
	thread_local@1.1.8
	time-core@0.1.2
	time-macros@0.2.19
	time@0.3.37
	tinystr@0.7.6
	tinyvec@1.8.1
	tinyvec_macros@0.1.1
	tui-textarea@0.7.0
	two-face@0.4.0
	typenum@1.17.0
	uluru@3.1.0
	unicode-bom@2.0.3
	unicode-ident@1.0.14
	unicode-normalization@0.1.24
	unicode-segmentation@1.12.0
	unicode-truncate@1.1.0
	unicode-truncate@2.0.0
	unicode-width@0.1.14
	unicode-width@0.2.0
	universal-hash@0.5.1
	url@2.5.4
	utf16_iter@1.0.5
	utf8_iter@1.0.4
	utf8parse@0.2.2
	vcpkg@0.2.15
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.99
	wasm-bindgen-macro-support@0.2.99
	wasm-bindgen-macro@0.2.99
	wasm-bindgen-shared@0.2.99
	wasm-bindgen@0.2.99
	which@7.0.1
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-core@0.57.0
	windows-implement@0.57.0
	windows-interface@0.57.0
	windows-result@0.1.2
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.48.5
	windows-targets@0.52.6
	windows@0.57.0
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
	winnow@0.6.22
	winsafe@0.0.19
	write16@1.0.0
	writeable@0.5.5
	yansi@1.0.1
	yoke-derive@0.7.5
	yoke@0.7.5
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zerofrom-derive@0.1.5
	zerofrom@0.1.5
	zeroize@1.8.1
	zerovec-derive@0.10.3
	zerovec@0.10.4
"

inherit cargo

DESCRIPTION="blazing fast terminal-ui for git"
HOMEPAGE="https://github.com/extrawurst/gitui"
SRC_URI="
	https://github.com/extrawurst/gitui/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD CC0-1.0 ISC MIT MPL-2.0 Unicode-3.0 ZLIB
"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/openssl:=
	net-libs/libssh2
	sys-libs/zlib
"
DEPEND="${RDEPEND}"

DOCS=( {README,KEY_CONFIG,THEMES}.md vim_style_key_config.ron )
QA_FLAGS_IGNORED="usr/bin/gitui"

src_configure() {
	# Use system library
	export LIBSSH2_SYS_USE_PKG_CONFIG=1
	# Use vendored version because libgit2 has strict version requirements
	# export LIBGIT2_NO_VENDOR=1

	local myfeatures=(
		ghemoji
		regex-fancy
		trace-libgit
	)
	cargo_src_configure --no-default-features
}

src_install() {
	cargo_src_install

	einstalldocs
}

pkg_postinst() {
	elog "Example vim style key config is installed in '${EROOT}/usr/share/doc/${PF}'."
	elog "To use it, copy the content into '\$XDG_CONFIG_HOME/gitui/key_configs.ron'."
}