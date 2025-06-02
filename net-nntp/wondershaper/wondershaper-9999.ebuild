# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit systemd git-r3


DESCRIPTION="Command-line utility for limiting an adapter's bandwidth"
HOMEPAGE="https://github.com/magnific0/wondershaper"
EGIT_REPO_URI="https://github.com/magnific0/${PN}"

LICENSE="GPL-2.0"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
dobin wondershaper
systemd_dounit wondershaper.service
newconfd wondershaper.conf wondershaper.conf
}
