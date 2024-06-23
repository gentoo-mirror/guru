# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Soothing theme for cursors"
HOMEPAGE="https://catppuccin.com"
SRC_URI="https://github.com/catppuccin/cursors/archive/refs/tags/v0.3.1.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/cursors-0.3.1"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	unzip ${DISTDIR}/*.zip
}

src_install() {
	mkdir --parents ${D}/usr/share/icons
	cp -r ${WORKDIR}/cursors-0.3.1/src/catppuccin-macchiato-* ${D}/usr/share/icons
}
