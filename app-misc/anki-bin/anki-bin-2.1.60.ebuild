# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

### A NOTE REGARDING PYTHON COMPATABILITY ###
# Anki-bin downloads a python 3.9 wheel. However the wheel used has only one native library _rsbridge.so
# that is not linked against libpython.
# The configuration with Python 3.10 was tested on a limited number of machines and is not guaranteed to work.

PYTHON_COMPAT=( python3_9 python3_10 )
inherit python-single-r1 desktop xdg

MY_PN=${PN%-bin}
DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net/"
SRC_URI="
	https://files.pythonhosted.org/packages/cp39/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}-cp39-abi3-manylinux_2_28_x86_64.whl -> ${P}.zip
	https://files.pythonhosted.org/packages/py3/a/aqt/aqt-${PV}-py3-none-any.whl -> aqt-${PV}.zip
	https://raw.githubusercontent.com/ankitects/${MY_PN}/${PV}/qt/bundle/lin/${MY_PN}.desktop -> ${P}.desktop
	https://raw.githubusercontent.com/ankitects/${MY_PN}/${PV}/qt/bundle/lin/${MY_PN}.png -> ${P}.png
	https://raw.githubusercontent.com/ankitects/${MY_PN}/${PV}/qt/bundle/lin/${MY_PN}.1 -> ${P}.1
"

LICENSE="AGPL-3+ Apache-2.0 BSD CC-BY-3.0 GPL-3+ MIT"
SLOT="0"
KEYWORDS="~amd64"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

QA_PREBUILT="usr/lib/*"
DEPEND="
$(python_gen_cond_dep '
	dev-python/decorator[${PYTHON_USEDEP}]
	dev-python/protobuf-python[${PYTHON_USEDEP}]
	dev-python/distro[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/waitress[${PYTHON_USEDEP}]
	dev-python/send2trash[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/flask-cors[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/PyQtWebEngine[${PYTHON_USEDEP}]
	dev-python/stringcase[${PYTHON_USEDEP}]
	')
"
RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	!app-misc/anki
"
BDEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	python_domodule anki anki-${PV}.dist-info _aqt aqt aqt-${PV}.dist-info
	printf "#!/usr/bin/python3\nimport sys;from aqt import run;sys.exit(run())" > runanki
	python_newscript runanki anki
	newicon "${DISTDIR}"/${P}.png ${MY_PN}.png
	newmenu "${DISTDIR}"/${P}.desktop ${MY_PN}.desktop
	newman "${DISTDIR}"/${P}.1 ${MY_PN}.1
}
