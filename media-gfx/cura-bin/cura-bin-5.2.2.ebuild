# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop

MY_PN="Cura-${PV}.Appimage"

DESCRIPTION="Open-source version of Google Chrome web browser"
HOMEPAGE="https://chromium.org/"
SRC_URI="https://github.com/Ultimaker/Cura/releases/download/${PV}/UltiMaker-Cura-${PV}-linux-modern.AppImage -> ${MY_PN}"

LICENSE="GPL-3.0"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="sys-apps/xdg-desktop-portal-gtk"

RESTRICT="binchecks strip"

S=${WORKDIR}

src_install() {
	cp ${DISTDIR}/${MY_PN} cura
	dobin cura
	make_desktop_entry cura Cura cura Graphics
}


