# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.4

EAPI=8

CRATES="
	addr2line@0.24.2
	adler2@2.0.0
	aead@0.5.2
	aes-gcm@0.10.3
	aes@0.8.4
	aho-corasick@1.1.3
	android-tzdata@0.1.1
	android_system_properties@0.1.5
	aperture@0.7.0
	arrayvec@0.7.6
	ashpd@0.9.2
	async-attributes@1.1.2
	async-broadcast@0.7.1
	async-channel@1.9.0
	async-channel@2.3.1
	async-executor@1.13.1
	async-fs@2.1.2
	async-global-executor@2.4.1
	async-io@2.3.4
	async-lock@3.4.0
	async-net@2.0.0
	async-process@2.3.0
	async-recursion@1.1.1
	async-signal@0.2.10
	async-std@1.13.0
	async-task@4.7.1
	async-trait@0.1.83
	async-tungstenite@0.28.0
	async_io_stream@0.3.3
	async_zip@0.0.17
	atomic-waker@1.1.2
	atomic_refcell@0.1.13
	autocfg@1.4.0
	backtrace@0.3.74
	base64@0.22.1
	bitflags@1.3.2
	bitflags@2.6.0
	blake2@0.10.6
	block-buffer@0.10.4
	block@0.1.6
	blocking@1.6.1
	bumpalo@3.16.0
	bytecodec@0.4.15
	bytemuck@1.19.0
	byteorder-lite@0.1.0
	byteorder@1.5.0
	bytes@1.7.2
	cairo-rs@0.20.1
	cairo-sys-rs@0.20.0
	cc@1.1.31
	cfg-expr@0.17.0
	cfg-if@1.0.0
	cfg_aliases@0.2.1
	chacha20@0.9.1
	chacha20poly1305@0.10.1
	chrono@0.4.38
	cipher@0.4.4
	concurrent-queue@2.5.0
	core-foundation-sys@0.8.7
	cpufeatures@0.2.14
	crc-catalog@2.4.0
	crc32fast@1.4.2
	crc@3.2.1
	crossbeam-utils@0.8.20
	crypto-common@0.1.6
	crypto_secretbox@0.1.1
	ctr@0.9.2
	curve25519-dalek-derive@0.1.1
	curve25519-dalek@4.1.3
	data-encoding@2.6.0
	deranged@0.3.11
	derive_more-impl@1.0.0
	derive_more@1.0.0
	digest@0.10.7
	either@1.13.0
	endi@1.1.0
	enumflags2@0.7.10
	enumflags2_derive@0.7.10
	env_logger@0.10.2
	equivalent@1.0.1
	errno@0.3.9
	event-listener-strategy@0.5.2
	event-listener@2.5.3
	event-listener@5.3.1
	fastrand@2.1.1
	fiat-crypto@0.2.9
	field-offset@0.3.6
	filetime@0.2.25
	flate2@1.0.34
	fnv@1.0.7
	form_urlencoded@1.2.1
	futures-channel@0.3.31
	futures-core@0.3.31
	futures-executor@0.3.31
	futures-io@0.3.31
	futures-lite@2.3.0
	futures-macro@0.3.31
	futures-sink@0.3.31
	futures-task@0.3.31
	futures-util@0.3.31
	futures@0.3.31
	gdk-pixbuf-sys@0.20.4
	gdk-pixbuf@0.20.4
	gdk4-sys@0.9.2
	gdk4-wayland-sys@0.9.2
	gdk4-wayland@0.9.2
	gdk4-win32-sys@0.9.2
	gdk4-win32@0.9.2
	gdk4-x11-sys@0.9.2
	gdk4-x11@0.9.2
	gdk4@0.9.2
	generic-array@0.14.7
	getrandom@0.2.15
	gettext-rs@0.7.2
	gettext-sys@0.22.5
	ghash@0.5.1
	gimli@0.31.1
	gio-sys@0.20.4
	gio@0.20.4
	glib-macros@0.20.4
	glib-sys@0.20.4
	glib@0.20.4
	gloo-timers@0.3.0
	gobject-sys@0.20.4
	graphene-rs@0.20.4
	graphene-sys@0.20.4
	gsk4-sys@0.9.2
	gsk4@0.9.2
	gst-plugin-gtk4@0.13.1
	gst-plugin-version-helper@0.8.2
	gstreamer-allocators-sys@0.23.2
	gstreamer-allocators@0.23.2
	gstreamer-audio-sys@0.23.2
	gstreamer-audio@0.23.2
	gstreamer-base-sys@0.23.2
	gstreamer-base@0.23.2
	gstreamer-gl-egl-sys@0.23.2
	gstreamer-gl-egl@0.23.2
	gstreamer-gl-sys@0.23.2
	gstreamer-gl-wayland-sys@0.23.2
	gstreamer-gl-wayland@0.23.2
	gstreamer-gl-x11-sys@0.23.2
	gstreamer-gl-x11@0.23.2
	gstreamer-gl@0.23.2
	gstreamer-pbutils-sys@0.23.2
	gstreamer-pbutils@0.23.2
	gstreamer-sys@0.23.2
	gstreamer-video-sys@0.23.2
	gstreamer-video@0.23.2
	gstreamer@0.23.2
	gtk4-macros@0.9.1
	gtk4-sys@0.9.2
	gtk4@0.9.2
	gvdb-macros@0.1.13
	gvdb@0.7.1
	hashbrown@0.15.0
	heck@0.5.0
	hermit-abi@0.4.0
	hex@0.4.3
	hkdf@0.12.4
	hmac@0.12.1
	http@1.1.0
	httparse@1.9.5
	humantime@2.1.0
	iana-time-zone-haiku@0.1.2
	iana-time-zone@0.1.61
	idna@0.5.0
	if-addrs@0.13.3
	image@0.25.4
	indexmap@2.6.0
	inout@0.1.3
	instant@0.1.13
	is-terminal@0.4.13
	itertools@0.13.0
	itoa@1.0.11
	js-sys@0.3.72
	kv-log-macro@1.0.7
	lazy_static@1.5.0
	libadwaita-sys@0.7.0
	libadwaita@0.7.0
	libc@0.2.161
	libredox@0.1.3
	license@3.5.1+3.25.0
	linux-raw-sys@0.4.14
	litrs@0.4.1
	locale_config@0.3.0
	lock_api@0.4.12
	log@0.4.22
	magic-wormhole@0.7.2
	malloc_buf@0.0.6
	md5@0.7.0
	memchr@2.7.4
	memmap2@0.9.5
	memoffset@0.9.1
	miniz_oxide@0.8.0
	muldiv@1.0.1
	nix@0.29.0
	noise-protocol@0.2.0
	noise-rust-crypto@0.6.2
	num-conv@0.1.0
	num-integer@0.1.46
	num-rational@0.4.2
	num-traits@0.2.19
	objc-foundation@0.1.1
	objc@0.2.7
	objc_id@0.1.1
	object@0.36.5
	once_cell@1.20.2
	opaque-debug@0.3.1
	option-operations@0.5.0
	ordered-stream@0.2.0
	pango-sys@0.20.4
	pango@0.20.4
	parking@2.2.1
	parking_lot@0.11.2
	parking_lot_core@0.8.6
	paste@1.0.15
	percent-encoding@2.3.1
	pharos@0.5.3
	pin-project-internal@1.1.6
	pin-project-lite@0.2.14
	pin-project@1.1.6
	pin-utils@0.1.0
	piper@0.2.4
	pkg-config@0.3.31
	polling@3.7.3
	poly1305@0.8.0
	polyval@0.6.2
	powerfmt@0.2.0
	ppv-lite86@0.2.20
	pretty_env_logger@0.5.0
	proc-macro-crate@3.2.0
	proc-macro2@1.0.88
	qrcode@0.14.1
	quick-xml@0.36.2
	quote@1.0.37
	rand@0.8.5
	rand_chacha@0.3.1
	rand_core@0.6.4
	redox_syscall@0.2.16
	redox_syscall@0.5.7
	regex-automata@0.4.8
	regex-syntax@0.8.5
	regex@1.11.0
	reword@7.0.0
	rmp-serde@1.3.0
	rmp@0.8.14
	rustc-demangle@0.1.24
	rustc_version@0.4.1
	rustix@0.38.37
	rustversion@1.0.18
	ryu@1.0.18
	salsa20@0.10.2
	same-file@1.0.6
	scopeguard@1.2.0
	semver@1.0.23
	send_wrapper@0.6.0
	serde@1.0.210
	serde_derive@1.0.210
	serde_json@1.0.132
	serde_repr@0.1.19
	serde_spanned@0.6.8
	sha-1@0.10.1
	sha1@0.10.6
	sha2@0.10.8
	shlex@1.3.0
	signal-hook-registry@1.4.2
	simple_moving_average@1.0.2
	slab@0.4.9
	smallvec@1.13.2
	smol@2.0.2
	socket2@0.5.7
	spake2@0.4.0
	static_assertions@1.1.0
	strum@0.26.3
	strum_macros@0.26.4
	stun_codec@0.3.5
	subtle@2.6.1
	syn@1.0.109
	syn@2.0.82
	system-deps@7.0.3
	tar@0.4.42
	target-lexicon@0.12.16
	temp-dir@0.1.14
	tempfile@3.13.0
	termcolor@1.4.1
	thiserror-impl@1.0.64
	thiserror@1.0.64
	time-core@0.1.2
	time-macros@0.2.18
	time@0.3.36
	tinyvec@1.8.0
	tinyvec_macros@0.1.1
	toml@0.8.19
	toml_datetime@0.6.8
	toml_edit@0.22.22
	tracing-attributes@0.1.27
	tracing-core@0.1.32
	tracing@0.1.40
	trackable@0.2.24
	trackable@1.3.0
	trackable_derive@1.0.0
	tungstenite@0.24.0
	typenum@1.17.0
	uds_windows@1.1.0
	unicode-bidi@0.3.17
	unicode-ident@1.0.13
	unicode-normalization@0.1.24
	unicode-segmentation@1.12.0
	unicode-xid@0.2.6
	universal-hash@0.5.1
	url@2.5.2
	urlencoding@2.1.3
	utf-8@0.7.6
	value-bag@1.9.0
	version-compare@0.2.0
	version_check@0.9.5
	walkdir@2.5.0
	wasi@0.11.0+wasi-snapshot-preview1
	wasm-bindgen-backend@0.2.95
	wasm-bindgen-futures@0.4.45
	wasm-bindgen-macro-support@0.2.95
	wasm-bindgen-macro@0.2.95
	wasm-bindgen-shared@0.2.95
	wasm-bindgen@0.2.95
	wasm-timer@0.2.5
	web-sys@0.3.72
	win32console@0.1.5
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-util@0.1.9
	winapi-x86_64-pc-windows-gnu@0.4.0
	winapi@0.3.9
	windows-core@0.52.0
	windows-sys@0.52.0
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.6.20
	ws_stream_wasm@0.7.4
	x25519-dalek@2.0.1
	xattr@1.3.1
	xdg-home@1.3.0
	zbus@4.4.0
	zbus_macros@4.4.0
	zbus_names@3.0.0
	zerocopy-derive@0.7.35
	zerocopy@0.7.35
	zeroize@1.8.1
	zeroize_derive@1.4.2
	zvariant@4.2.0
	zvariant_derive@4.2.0
	zvariant_utils@2.1.0
"

PYTHON_COMPAT=( python3_{11..13} )
inherit cargo flag-o-matic gnome2-utils meson python-any-r1 xdg

DESCRIPTION="Fast and secure file transfer"
HOMEPAGE="
	https://apps.gnome.org/Warp/
	https://gitlab.gnome.org/World/warp
"
SRC_URI="
	https://gitlab.gnome.org/World/warp/-/archive/v${PV}/${PN}-v${PV}.tar.bz2 -> ${P}.tar.bz2
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/${PN}-v${PV}"
ECARGO_HOME="${WORKDIR}/${P}-build/cargo-home"

LICENSE="GPL-3"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD EUPL-1.2 GPL-3+ MIT
	MPL-2.0 Unicode-DFS-2016 Unlicense
"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qrcode"

DEPEND="
	>=dev-libs/glib-2.76:2
	>=gui-libs/gtk-4.13:4[wayland,X]
	>=gui-libs/libadwaita-1.6:1
	qrcode? (
		media-libs/graphene
		>=media-libs/gstreamer-1.18:1.0
		>=media-libs/gst-plugins-bad-1.18:1.0
		>=media-libs/gst-plugins-base-1.18:1.0[wayland]
		>=media-libs/gst-plugins-good-1.18:1.0
		>=media-plugins/gst-plugins-zbar-1.18:1.0
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	dev-util/itstool
"

QA_FLAGS_IGNORED="usr/bin/warp"

pkg_setup() {
	python-any-r1_pkg_setup
	rust_pkg_setup
}

src_prepare() {
	default
	python_fix_shebang build-aux/meson-cargo-manifest.py
}

src_configure() {
	filter-lto

	local emesonargs=(
		$(meson_feature qrcode qr-code-scanning)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}