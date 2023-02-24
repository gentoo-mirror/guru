# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..9} )
inherit distutils-r1 udev

DESCRIPTION="Library and command line tool for interacting with hardware wallets"
HOMEPAGE="https://github.com/bitcoin-core/HWI"

MY_PN="HWI"
MY_P="${MY_PN}-${PV}"
SRC_URI="https://github.com/bitcoin-core/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="udev"

RDEPEND="
	>=dev-python/bitbox02-5.3.0[${PYTHON_USEDEP}]
	>=dev-python/ecdsa-0.13.0[${PYTHON_USEDEP}]
	>=dev-python/hidapi-0.7.99[${PYTHON_USEDEP}]
	>=dev-python/libusb1-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/mnemonic-0.18.0[${PYTHON_USEDEP}]
	>=dev-python/pyaes-1.6.0[${PYTHON_USEDEP}]
	>=dev-python/typing-extensions-3.7.4.1[${PYTHON_USEDEP}]"

distutils_enable_tests unittest

distutils_enable_sphinx docs \
	dev-python/sphinx-rtd-theme \
	dev-python/sphinxcontrib-autoprogram

python_prepare_all() {
	# remove upper bounds on dependencies from setup.py file
	sed 's/,<[0-9.]\+//' -i setup.py || die

	pushd test || die
	# remove tests that require hardware emulation
	rm test_coldcard.py test_device.py test_digitalbitbox.py test_keepkey.py test_ledger.py test_trezor.py || die
	# remove udev tests because it expects the rules are installed in the libs folder
	rm test_udevrules.py || die
	popd || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	use udev && udev_dorules hwilib/udev/*.rules
	use doc  && dodoc -r docs

	distutils-r1_python_install_all
}
