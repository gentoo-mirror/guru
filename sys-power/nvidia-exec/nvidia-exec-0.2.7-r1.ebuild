# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/pedro00dk/nvidia-exec.git"
else
	SRC_URI="https://github.com/pedro00dk/nvidia-exec/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="GPU switching without login out for Nvidia Optimus laptops under Linux"
HOMEPAGE="https://github.com/pedro00dk/nvidia-exec"

LICENSE="GPL-3"
SLOT="0"

RDEPEND="
	dev-lang/python
	sys-apps/lshw
	sys-process/lsof
	x11-drivers/nvidia-drivers
"

src_install() {
	newbin "${WORKDIR}/${P}/nvx.py" nvx
	systemd_dounit "${WORKDIR}/${P}/nvx.service"
	insinto /usr/lib/modprobe.d
	newins "${WORKDIR}/${P}/nvx-modprobe.conf" nvx.conf
	insinto /etc/
	newins "${WORKDIR}/${P}/nvx-options.conf" nvx.conf
}

pkg_postinst() {
	ewarn "Don't forget to enable the nvx service:\nsystemctl enable --now nvx\n"
	ewarn "\nThe nvx.service prevents nvidia modules from loading and turn off the graphics card during boot.\n"
	ewarn "It is not necessary to handle files, configurations, PCI buses, etc, all that is done automatically.\n"
}
