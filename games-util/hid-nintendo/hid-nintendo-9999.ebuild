# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-mod-r1

DESCRIPTION="A Nintendo HID kernel module"
HOMEPAGE="https://github.com/nicman23/dkms-hid-nintendo https://github.com/DanielOgorchock/linux"
EGIT_REPO_URI="https://github.com/nicman23/dkms-hid-nintendo"

LICENSE="GPL-2"
SLOT="0"

CONFIG_CHECK="~HID ~HID_GENERIC ~USB_HID ~HIDRAW ~UHID"

src_prepare() {
	default
	sed -i 's|<asm/unaligned.h>|<linux/unaligned.h>|' src/hid-nintendo.c || die
}

src_compile() {
	local modlist=( src/hid-nintendo="${S}/src" )
	local modargs=( -C "${KV_DIR}" M="${S}/src" )

	linux-mod-r1_src_compile
}
