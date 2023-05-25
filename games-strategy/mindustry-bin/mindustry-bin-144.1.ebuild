# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="${PN/-bin/}"

inherit wrapper desktop xdg

DESCRIPTION="A sandbox tower defense game"
HOMEPAGE="https://mindustrygame.github.io"
SRC_URI="https://github.com/Anuken/${MY_PN^}/releases/download/v${PV}/${MY_PN^}.jar -> ${P}.jar"

RESTRICT="bindist mirror strip test"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	>=virtual/jre-1.7:*
"

S="${DISTDIR}"

src_unpack() {
	:
}

src_install() {
	insinto "/opt/${PN}"
	newins "${P}.jar" "${PN}.jar"

	make_wrapper "${PN}" "java -jar /opt/${PN}/${PN}.jar"
	# FIXME: don't relay on 3rd party icons
	make_desktop_entry "${PN}" "${PN^}" "${MY_PN}" "Game;StrategyGame;"
}
