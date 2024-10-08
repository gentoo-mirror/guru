# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PN="${PN^}"
MY_PV="v${PV}"
MY_P="${MY_PN}_${MY_PV}"
MY_P_NF="${MY_PN}Nerd_${MY_PV}"

DESCRIPTION="Firge is a composite font of Fira Mono and GenShin-Gothic."
HOMEPAGE="https://github.com/yuru7/Firge"
SRC_URI="https://github.com/yuru7/Firge/releases/download/${MY_PV}/${MY_P}.zip
	nerdfonts? ( https://github.com/yuru7/Firge/releases/download/${MY_PV}/${MY_P_NF}.zip )
"

S="${WORKDIR}"
FONT_SUFFIX="ttf"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86"
IUSE="nerdfonts"

BDEPEND="app-arch/unzip"

src_unpack() {
	default
	mv ${MY_P}/*.${FONT_SUFFIX} . || die
	if use nerdfonts; then
		mv ${MY_P_NF}/*.${FONT_SUFFIX} . || die
	fi
}
