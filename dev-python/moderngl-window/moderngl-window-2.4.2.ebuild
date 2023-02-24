# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_10 )

inherit distutils-r1 virtualx

DESCRIPTION="A cross platform utility library for ModernGL"
HOMEPAGE="https://github.com/moderngl/moderngl-window https://pypi.org/project/moderngl-window"
SRC_URI="https://github.com/moderngl/moderngl-window/archive/refs/tags/${PV}.tar.gz -> v${PV}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/wheel[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/tox[${PYTHON_USEDEP}]
		dev-python/flake8[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/moderngl[${PYTHON_USEDEP}]
		dev-python/glcontext[${PYTHON_USEDEP}]
		dev-python/trimesh[${PYTHON_USEDEP}]
		dev-python/PyWavefront[${PYTHON_USEDEP}]
	)
"
DEPEND="${BDEPEND}"

distutils_enable_tests pytest
src_test() {
	virtx distutils-r1_src_test
}
