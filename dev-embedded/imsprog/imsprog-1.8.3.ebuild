# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake udev

DESCRIPTION="I2C, MicroWire and SPI EEPROM/Flash chip Programmer"
HOMEPAGE="https://github.com/bigbigmdm/IMSProg"
SRC_URI="https://github.com/bigbigmdm/IMSProg/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/IMSProg-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libusb
	dev-qt/qtwidgets
	dev-qt/qtnetwork
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-build/cmake
	dev-qt/linguist-tools
	dev-util/pkgconf
	sys-apps/systemd-utils
	app-arch/gzip
"

src_install() {
	cmake_src_install
	mv "${D}"/usr/share/doc/imsprog/* "${D}"/usr/share/doc/imsprog-${PV}
	rmdir "${D}"/usr/share/doc/imsprog || die "/usr/share/doc/imsprog not empty"
	gunzip "${D}"/usr/share/man/man1/*
}

pkg_postrm() {
	udev_reload
}

pkg_postinst() {
	udev_reload
}
