# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
DISTUTILS_USE_PEP517=hatchling
inherit distutils-r1 pypi

DESCRIPTION="Python implementation of Protocol Buffers data types with dataclasses support"
HOMEPAGE="
	https://github.com/eigenein/protobuf
	https://pypi.org/project/pure-protobuf/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

# ModuleNotFoundError
RESTRICT="test"

BDEPEND="dev-python/hatch-vcs[${PYTHON_USEDEP}]"

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}
