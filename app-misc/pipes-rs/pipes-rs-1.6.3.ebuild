# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.5.4-r1

EAPI=8

CRATES="
	anyhow@1.0.75
	autocfg@1.1.0
	bitflags@1.3.2
	bitflags@2.4.1
	cc@1.0.83
	cfg-if@1.0.0
	crossterm@0.27.0
	crossterm_winapi@0.9.1
	equivalent@1.0.1
	hashbrown@0.14.1
	home@0.5.5
	indexmap@2.0.2
	libc@0.2.149
	libmimalloc-sys@0.1.35
	lock_api@0.4.10
	log@0.4.20
	memchr@2.6.4
	mimalloc@0.1.39
	mio@0.8.8
	once_cell@1.18.0
	oorandom@11.1.3
	parking_lot@0.12.1
	parking_lot_core@0.9.8
	proc-macro2@1.0.69
	quote@1.0.33
	redox_syscall@0.3.5
	scopeguard@1.2.0
	serde@1.0.189
	serde_derive@1.0.189
	serde_spanned@0.6.3
	signal-hook@0.3.17
	signal-hook-mio@0.2.3
	signal-hook-registry@1.4.1
	smallvec@1.11.1
	syn@2.0.38
	tincture@1.0.0
	toml@0.8.2
	toml_datetime@0.6.3
	toml_edit@0.20.2
	unicode-ident@1.0.12
	unicode-width@0.1.11
	wasi@0.11.0+wasi-snapshot-preview1
	winapi@0.3.9
	winapi-i686-pc-windows-gnu@0.4.0
	winapi-x86_64-pc-windows-gnu@0.4.0
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	winnow@0.5.17
"

inherit cargo

DESCRIPTION="An over-engineered rewrite of pipes.sh in Rust"
HOMEPAGE="https://github.com/lhvy/pipes-rs"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lhvy/pipes-rs.git"
else
	SRC_URI="https://github.com/lhvy/pipes-rs/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}"
	KEYWORDS="~amd64"
fi

LICENSE="BlueOak-1.0.0 Apache-2.0 MIT Unicode-DFS-2016"
SLOT="0"

PATCHES=(
	"${FILESDIR}/${PN}-1.6.3-do-not-strip.patch"
)

QA_FLAGS_IGNORED="usr/bin/${PN}"

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		git-r3_src_unpack
		cargo_live_src_unpack
	else
		cargo_src_unpack
	fi
}

src_install() {
	cargo_src_install --path ./crates/${PN}
}
