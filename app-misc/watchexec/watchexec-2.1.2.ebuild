# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	addr2line@0.21.0
	adler@1.0.2
	ahash@0.8.11
	aho-corasick@1.1.3
	allocator-api2@0.2.18
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	anstream@0.6.13
	anstyle@1.0.6
	anstyle-parse@0.2.3
	anstyle-query@1.0.2
	anstyle-wincon@3.0.2
	anyhow@1.0.82
	arc-swap@1.7.1
	argfile@0.2.0
	arrayref@0.3.7
	arrayvec@0.7.4
	async-broadcast@0.7.0
	async-channel@2.2.1
	async-executor@1.11.0
	async-fs@2.1.1
	async-io@2.3.2
	async-lock@2.8.0
	async-lock@3.3.0
	async-priority-channel@0.2.0
	async-process@2.2.1
	async-recursion@1.1.0
	async-signal@0.2.5
	async-stream@0.3.5
	async-stream-impl@0.3.5
	async-task@4.7.0
	async-trait@0.1.80
	atomic-take@1.1.0
	atomic-waker@1.1.2
	autocfg@1.2.0
	axum@0.6.20
	axum-core@0.3.4
	backtrace@0.3.71
	backtrace-ext@0.2.1
	base64@0.21.7
	bincode@1.3.3
	bitflags@1.3.2
	bitflags@2.5.0
	blake3@1.5.1
	block@0.1.6
	block-buffer@0.10.4
	blocking@1.5.1
	boxcar@0.2.4
	bstr@1.9.1
	bumpalo@3.16.0
	byteorder@1.5.0
	bytes@1.6.0
	c-gull@0.15.43
	c-scape@0.15.43
	cc@1.0.95
	cfg-if@1.0.0
	cfg_aliases@0.1.1
	chrono@0.4.38
	chumsky@0.9.3
	clap@4.5.4
	clap_builder@4.5.2
	clap_complete@4.5.2
	clap_complete_nushell@4.5.1
	clap_derive@4.5.4
	clap_lex@0.7.0
	clap_mangen@0.2.20
	clearscreen@3.0.0
	clru@0.6.1
	colorchoice@1.0.0
	command-group@2.1.0
	concurrent-queue@2.4.0
	console-api@0.6.0
	console-subscriber@0.2.0
	constant_time_eq@0.3.0
	core-foundation-sys@0.8.6
	cpufeatures@0.2.12
	crc32fast@1.4.0
	crossbeam-channel@0.5.12
	crossbeam-deque@0.8.5
	crossbeam-epoch@0.9.18
	crossbeam-utils@0.8.19
	crypto-common@0.1.6
	cstr_core@0.2.6
	cty@0.2.2
	dashmap@5.5.3
	deranged@0.3.11
	derivative@2.2.0
	digest@0.10.7
	dirs@4.0.0
	dirs@5.0.1
	dirs-next@2.0.0
	dirs-sys@0.3.7
	dirs-sys@0.4.1
	dirs-sys-next@0.1.2
	dunce@1.0.4
	dyn-clone@1.0.17
	either@1.11.0
	embed-resource@2.4.2
	endi@1.1.0
	endian-type@0.1.2
	enumflags2@0.7.9
	enumflags2_derive@0.7.9
	env_logger@0.10.2
	equivalent@1.0.1
	errno@0.3.8
	event-listener@2.5.3
	event-listener@4.0.3
	event-listener@5.3.0
	event-listener-strategy@0.4.0
	event-listener-strategy@0.5.1
	eyra@0.16.10
	faster-hex@0.9.0
	fastrand@2.0.2
	filetime@0.2.23
	flate2@1.0.28
	fnv@1.0.7
	form_urlencoded@1.2.1
	fs-err@2.11.0
	fsevent-sys@4.1.0
	futures@0.3.30
	futures-channel@0.3.30
	futures-core@0.3.30
	futures-executor@0.3.30
	futures-io@0.3.30
	futures-lite@2.3.0
	futures-macro@0.3.30
	futures-sink@0.3.30
	futures-task@0.3.30
	futures-util@0.3.30
	generic-array@0.14.7
	getrandom@0.2.14
	gimli@0.28.1
	gix@0.62.0
	gix-actor@0.31.1
	gix-bitmap@0.2.11
	gix-chunk@0.4.8
	gix-commitgraph@0.24.2
	gix-config@0.36.1
	gix-config-value@0.14.6
	gix-date@0.8.5
	gix-diff@0.43.0
	gix-discover@0.31.0
	gix-features@0.38.1
	gix-fs@0.10.2
	gix-glob@0.16.2
	gix-hash@0.14.2
	gix-hashtable@0.5.2
	gix-index@0.32.1
	gix-lock@13.1.1
	gix-macros@0.1.4
	gix-object@0.42.1
	gix-odb@0.60.0
	gix-pack@0.50.0
	gix-path@0.10.7
	gix-quote@0.4.12
	gix-ref@0.43.0
	gix-refspec@0.23.0
	gix-revision@0.27.0
	gix-revwalk@0.13.0
	gix-sec@0.10.6
	gix-tempfile@13.1.1
	gix-trace@0.1.9
	gix-traverse@0.39.0
	gix-url@0.27.3
	gix-utils@0.1.12
	gix-validate@0.8.4
	globset@0.4.14
	h2@0.3.26
	hashbrown@0.12.3
	hashbrown@0.14.3
	hdrhistogram@7.5.4
	heck@0.5.0
	hermit-abi@0.3.9
	hex@0.4.3
	hifijson@0.2.1
	home@0.5.9
	http@0.2.12
	http-body@0.4.6
	httparse@1.8.0
	httpdate@1.0.3
	humantime@2.1.0
	hyper@0.14.28
	hyper-timeout@0.4.1
	iana-time-zone@0.1.60
	iana-time-zone-haiku@0.1.2
	idna@0.5.0
	ignore@0.4.22
	indexmap@1.9.3
	indexmap@2.2.6
	inotify@0.9.6
	inotify-sys@0.1.5
	is-terminal@0.4.12
	is_ci@1.2.0
	itertools@0.9.0
	itertools@0.12.1
	itoa@1.0.11
	jaq-core@1.2.1
	jaq-interpret@1.2.1
	jaq-parse@1.0.2
	jaq-std@1.2.1
	jaq-syn@1.1.0
	js-sys@0.3.69
	kqueue@1.0.8
	kqueue-sys@1.0.4
	lazy_static@1.4.0
	libc@0.2.153
	libm@0.2.8
	libmimalloc-sys@0.1.35
	libredox@0.1.3
	linux-raw-sys@0.4.13
	lock_api@0.4.11
	log@0.4.21
	mac-notification-sys@0.6.1
	malloc_buf@0.0.6
	matchers@0.1.0
	matchit@0.7.3
	memchr@2.7.2
	memmap2@0.9.4
	memoffset@0.9.1
	miette@7.2.0
	miette-derive@7.2.0
	mimalloc@0.1.39
	mime@0.3.17
	minimal-lexical@0.2.1
	miniz_oxide@0.7.2
	mio@0.8.11
	nibble_vec@0.1.0
	nix@0.26.4
	nix@0.27.1
	nix@0.28.0
	nom@7.1.3
	normalize-line-endings@0.3.0
	normalize-path@0.2.1
	notify@6.1.1
	notify-rust@4.11.0
	nu-ansi-term@0.46.0
	num-complex@0.4.5
	num-conv@0.1.0
	num-traits@0.2.18
	num_cpus@1.16.0
	num_threads@0.1.7
	objc@0.2.7
	objc-foundation@0.1.1
	objc_id@0.1.1
	object@0.32.2
	once_cell@1.19.0
	option-ext@0.2.0
	ordered-stream@0.2.0
	origin@0.18.2
	os_str_bytes@6.6.1
	overload@0.1.1
	owo-colors@4.0.0
	parking@2.2.0
	parking_lot@0.12.1
	parking_lot_core@0.9.9
	percent-encoding@2.3.1
	phf@0.11.2
	phf_codegen@0.11.2
	phf_generator@0.11.2
	phf_shared@0.11.2
	pid1@0.1.1
	pin-project@1.1.5
	pin-project-internal@1.1.5
	pin-project-lite@0.2.14
	pin-utils@0.1.0
	piper@0.2.1
	polling@3.6.0
	posix-regex@0.1.1
	powerfmt@0.2.0
	ppv-lite86@0.2.17
	printf-compat@0.1.1
	proc-macro-crate@3.1.0
	proc-macro2@1.0.81
	process-wrap@8.0.0
	prodash@28.0.0
	prost@0.12.4
	prost-derive@0.12.4
	prost-types@0.12.4
	quick-xml@0.31.0
	quote@1.0.36
	radix_trie@0.2.1
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	rand_pcg@0.3.1
	rayon@1.10.0
	rayon-core@1.12.1
	realpath-ext@0.1.3
	redox_syscall@0.4.1
	redox_users@0.4.5
	regex@1.10.4
	regex-automata@0.1.10
	regex-automata@0.4.6
	regex-syntax@0.6.29
	regex-syntax@0.8.3
	roff@0.2.1
	rustc-demangle@0.1.23
	rustc_version@0.4.0
	rustix@0.38.32
	rustix-dlmalloc@0.1.5
	rustix-futex-sync@0.2.1
	rustix-openpty@0.1.1
	rustversion@1.0.15
	ryu@1.0.17
	same-file@1.0.6
	scopeguard@1.2.0
	semver@1.0.22
	serde@1.0.198
	serde_derive@1.0.198
	serde_json@1.0.116
	serde_repr@0.1.19
	serde_spanned@0.6.5
	sha1@0.10.6
	sha1_smol@1.0.0
	sharded-slab@0.1.7
	signal-hook@0.3.17
	signal-hook-registry@1.4.1
	similar@2.5.0
	siphasher@0.3.11
	slab@0.4.9
	smallvec@1.13.2
	smawk@0.3.2
	snapbox@0.5.9
	snapbox-macros@0.3.8
	socket2@0.5.6
	static_assertions@1.1.0
	strsim@0.11.1
	supports-color@3.0.0
	supports-hyperlinks@3.0.0
	supports-unicode@3.0.0
	syn@1.0.109
	syn@2.0.60
	sync_wrapper@0.1.2
	tauri-winrt-notification@0.2.1
	tempfile@3.10.1
	termcolor@1.4.1
	terminal_size@0.3.0
	terminfo@0.8.0
	textwrap@0.16.1
	thiserror@1.0.58
	thiserror-impl@1.0.58
	thread_local@1.1.8
	time@0.3.36
	time-core@0.1.2
	time-macros@0.2.18
	tinyvec@1.6.0
	tinyvec_macros@0.1.1
	tokio@1.37.0
	tokio-io-timeout@1.2.0
	tokio-macros@2.2.0
	tokio-stream@0.1.15
	tokio-util@0.7.10
	toml@0.8.12
	toml_datetime@0.6.5
	toml_edit@0.21.1
	toml_edit@0.22.12
	tonic@0.10.2
	tower@0.4.13
	tower-layer@0.3.2
	tower-service@0.3.2
	tracing@0.1.40
	tracing-appender@0.2.3
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing-log@0.2.0
	tracing-serde@0.1.3
	tracing-subscriber@0.3.18
	tracing-test@0.2.4
	tracing-test-macro@0.2.4
	try-lock@0.2.5
	typenum@1.17.0
	tz-rs@0.6.14
	uds_windows@1.1.0
	unicode-bidi@0.3.15
	unicode-bom@2.0.3
	unicode-ident@1.0.12
	unicode-linebreak@0.1.5
	unicode-normalization@0.1.23
	unicode-width@0.1.11
	unwinding@0.2.1
	url@2.5.0
	urlencoding@2.1.3
	utf8parse@0.2.1
	uuid@1.8.0
	valuable@0.1.0
	version_check@0.9.4
	vswhom@0.1.0
	vswhom-sys@0.1.2
	walkdir@2.5.0
	want@0.3.1
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen@0.2.92
	wasm-bindgen-backend@0.2.92
	wasm-bindgen-macro@0.2.92
	wasm-bindgen-macro-support@0.2.92
	wasm-bindgen-shared@0.2.92
	which@6.0.1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.6
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows@0.56.0
	windows-core@0.52.0
	windows-core@0.56.0
	windows-implement@0.56.0
	windows-interface@0.56.0
	windows-result@0.1.1
	windows-sys@0.48.0
	windows-sys@0.52.0
	windows-targets@0.48.5
	windows-targets@0.52.5
	windows-version@0.1.1
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_gnullvm@0.52.5
	windows_aarch64_msvc@0.48.5
	windows_aarch64_msvc@0.52.5
	windows_i686_gnu@0.48.5
	windows_i686_gnu@0.52.5
	windows_i686_gnullvm@0.52.5
	windows_i686_msvc@0.48.5
	windows_i686_msvc@0.52.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnu@0.52.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_gnullvm@0.52.5
	windows_x86_64_msvc@0.48.5
	windows_x86_64_msvc@0.52.5
	winnow@0.5.40
	winnow@0.6.6
	winreg@0.52.0
	winsafe@0.0.19
	xdg-home@1.1.0
	zbus@4.1.2
	zbus_macros@4.1.2
	zbus_names@3.0.0
	zerocopy@0.7.32
	zerocopy-derive@0.7.32
	zvariant@4.0.2
	zvariant_derive@4.0.2
	zvariant_utils@1.1.0
"

inherit cargo shell-completion

DESCRIPTION="Executes commands in response to file modifications"
HOMEPAGE="https://watchexec.github.io/"
SRC_URI="https://github.com/watchexec/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" ${CARGO_CRATE_URIS}"

LICENSE="Apache-2.0 BSD BSD-2 CC0-1.0 ISC MIT MPL-2.0 Unicode-DFS-2016 WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Prevent portage from trying to fetch bunch of *.crate from mirror despite they are not mirrored.
RESTRICT="mirror"

DOCS=( crates/cli/README.md )

# rust does not use *FLAGS from make.conf, silence portage warning
# update with proper path to binaries this crate installs, omit leading /
QA_FLAGS_IGNORED="usr/bin/${PN}"

src_compile() {
	cargo_src_compile --manifest-path=crates/cli/Cargo.toml
}

src_test() {
	cargo_src_test --manifest-path crates/lib/Cargo.toml --lib
	cargo_src_test --manifest-path crates/cli/Cargo.toml
}

src_install() {
	cargo_src_install --path "${S}"/crates/cli

	einstalldocs
	doman doc/watchexec.1

	newbashcomp completions/bash "${PN}"

	newzshcomp completions/zsh "_${PN}"

	newfishcomp completions/fish "${PN}.fish"
}
