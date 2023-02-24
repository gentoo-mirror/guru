# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="py.test fixture for benchmarking code"
HOMEPAGE="
	https://pypi.python.org/pypi/pytest-benchmark/
	https://github.com/ionelmc/pytest-benchmark
"
SRC_URI="https://github.com/ionelmc/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

DOCS=( {AUTHORS,CHANGELOG,README}.rst )

RDEPEND="
	dev-python/py-cpuinfo[${PYTHON_USEDEP}]
	dev-python/pytest[${PYTHON_USEDEP}]
"
BDEPEND="test? (
	dev-python/aspectlib[${PYTHON_USEDEP}]
	dev-python/elasticsearch-py[${PYTHON_USEDEP}]
	dev-python/freezegun[${PYTHON_USEDEP}]
	dev-python/hunter[${PYTHON_USEDEP}]
	dev-python/pygal[${PYTHON_USEDEP}]
	dev-python/pygaljs[${PYTHON_USEDEP}]
	dev-python/pytest-xdist[${PYTHON_USEDEP}]
	dev-vcs/git
	dev-vcs/mercurial
)" # tests include pytest-xdist integration

EPYTEST_DESELECT=(
	tests/test_cli.py::test_help
	tests/test_cli.py::test_help_compare
)

distutils_enable_tests pytest

distutils_enable_sphinx docs \
	dev-python/sphinx-py3doc-enhanced-theme
