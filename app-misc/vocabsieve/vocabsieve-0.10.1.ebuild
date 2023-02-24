# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1

DESCRIPTION="A simple, effective tool for language learning"
HOMEPAGE="https://github.com/FreeLanguageTools/vocabsieve/ https://pypi.org/project/vocabsieve/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/simplemma[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/flask-sqlalchemy[${PYTHON_USEDEP}]
	dev-python/pysubs2[${PYTHON_USEDEP}]
	dev-python/bidict[${PYTHON_USEDEP}]
	dev-python/pystardict[${PYTHON_USEDEP}]
	dev-python/pymorphy2[${PYTHON_USEDEP}]
	dev-python/pymorphy2-dicts-ru[${PYTHON_USEDEP}]
	dev-python/pymorphy2-dicts-uk[${PYTHON_USEDEP}]
	dev-python/pyqtdarktheme[${PYTHON_USEDEP}]
	dev-python/charset_normalizer[${PYTHON_USEDEP}]
	dev-python/EbookLib[${PYTHON_USEDEP}]
	dev-python/sentence-splitter[${PYTHON_USEDEP}]
	dev-python/mobi[${PYTHON_USEDEP}]
	dev-python/SLPP[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/markdownify[${PYTHON_USEDEP}]
	dev-python/readmdict[${PYTHON_USEDEP}]
	dev-python/python-lzo[${PYTHON_USEDEP}]
	dev-python/pyqtgraph[${PYTHON_USEDEP}]
"
