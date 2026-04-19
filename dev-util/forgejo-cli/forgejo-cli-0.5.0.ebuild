# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES=' '
RUST_MIN_VER="1.88.0"

inherit cargo

DESCRIPTION="CLI application for interacting with Forgejo"
HOMEPAGE="https://codeberg.org/forgejo-contrib/forgejo-cli"
SRC_URI="
	https://codeberg.org/forgejo-contrib/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.xz
	https://github.com/gentoo-crate-dist/${PN}/releases/download/v${PV}/${P}-crates.tar.xz
"

S="${WORKDIR}/${PN}"

LICENCE="MIT"
#Crate Licenses
LICENSE+=" BSD-2 BSD Unicode-3.0 Apache-2.0 ISC MPL-2.0 ZLIB "
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="mirror"
