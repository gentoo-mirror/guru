# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils gnome2-utils

DESCRIPTION="Run websites as if they were apps"
HOMEPAGE="https://github.com/linuxmint/webapp-manager"
SRC_URI="https://github.com/linuxmint/webapp-manager/archive/refs/tags/${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-python/beautifulsoup4
         dev-python/configobj
         dev-python/pygobject
         dev-python/pillow
         dev-python/setproctitle
         dev-python/tldextract
         gnome-base/dconf
         x11-libs/xapp"
# build-time deps that need to be binary compatible with system
DEPEND="${DEPEND}"

# build-time deps executed during emerge process
BDEPEND="virtual/pkgconfig"

src_install() {
  cp -r etc usr "${ED}"
}

pkg_preinst() {
  gnome2_schemas_savelist
}

pkg_postinst() {
  gnome2_schemas_update
  xdg_icon_cache_update
}

pkg_postrm() {
  gnome2_schemas_update
  xdg_icon_cache_update
}
