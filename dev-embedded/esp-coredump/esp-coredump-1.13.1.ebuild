# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )

inherit distutils-r1 pypi

DESCRIPTION="Utility that helps users to retrieve and analyse core dumps"
HOMEPAGE="https://github.com/espressif/esp-coredump"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT="test"

RDEPEND="
	dev-embedded/esptool
	dev-python/construct[${PYTHON_USEDEP}]
	dev-python/pygdbmi[${PYTHON_USEDEP}]
"

DEPEND="${RDEPEND}"

src_prepare() {
	default
	rm -r tests || die
}
