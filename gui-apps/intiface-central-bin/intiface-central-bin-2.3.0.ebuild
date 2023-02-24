# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop

DESCRIPTION="Buttplug frontend application"
HOMEPAGE="https://github.com/intiface/intiface-central"
SRC_URI="https://github.com/intiface/intiface-central/releases/download/v${PV}/intiface-central-v${PV}-linux-x64.zip"
S="${WORKDIR}/intiface-central-v${PV}-linux-x64"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	app-accessibility/at-spi2-core
	media-gfx/graphite2
	sys-apps/dbus
	sys-apps/systemd-utils
	x11-libs/gtk+:3[X]
"
BDEPEND="app-arch/unzip"

QA_PREBUILT="/opt/${PN}/lib/*.so"

src_install() {
	insinto /opt/${PN}
	doins -r .
	fperms +x /opt/${PN}/intiface_central

	cat << EOF > intiface_central
#!/bin/sh
cd /opt/${PN}
./intiface_central "\${@}"
EOF
	dobin intiface_central

	newicon --size 512 \
		/opt/${PN}/data/flutter_assets/assets/icons/intiface_central_icon.png \
		${PN}.png

	make_desktop_entry intiface_central "Intiface Central" ${PN} "Utility"
}
