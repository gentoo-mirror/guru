# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{9..11} )

DOCS_BUILDER="mkdocs"
DOCS_DEPEND="
	dev-python/ansi2html
	dev-python/markdown
	dev-python/markdown-include
	dev-python/mkdocs-exclude
	dev-python/mkdocs-material
	dev-python/pygments
"

inherit distutils-r1 docs

MYPN="python-${PN}"
MYP="${MYPN}-${PV}"

DESCRIPTION="Dev tools for python"
HOMEPAGE="https://github.com/samuelcolvin/python-devtools"
SRC_URI="https://github.com/samuelcolvin/${MYPN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"
RESTRICT="!test? ( test )"

LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"

S="${WORKDIR}/${MYP}"

DEPEND="
	dev-python/asttokens[${PYTHON_USEDEP}]
	dev-python/executing[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
	test? (
		dev-python/asyncpg[${PYTHON_USEDEP}]
		dev-python/coverage[${PYTHON_USEDEP}]
		dev-python/multidict[${PYTHON_USEDEP}]
		dev-python/pydantic[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
		dev-python/sqlalchemy[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest
