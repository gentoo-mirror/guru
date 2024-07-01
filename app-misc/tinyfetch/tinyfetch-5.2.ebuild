# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

SRC_URI="https://github.com/kernaltrap8/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${PN}.tar.gz"

DESCRIPTION="fetch program written in pure C"
HOMEPAGE="https://github.com/kernaltrap8/tinyfetch"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc64"

IUSE="+pci"

RDEPEND="
	pci? (
		sys-apps/pciutils
	)
"
DEPEND="${RDEPEND}"
