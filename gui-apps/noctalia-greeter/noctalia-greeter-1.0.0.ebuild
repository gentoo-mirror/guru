# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A minimal login greeter for greetd that matches Noctalia Shell"
HOMEPAGE="https://noctalia.dev/ https://github.com/noctalia-dev/noctalia-greeter"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/noctalia-dev/${PN}.git"
else
	SRC_URI="https://github.com/noctalia-dev/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-libs/glib:2
	dev-libs/wayland
	gnome-base/librsvg:2
	media-libs/fontconfig
	media-libs/freetype
	sys-apps/dbus
	gui-libs/greetd
	gui-libs/wlroots:0.20=
	x11-libs/pango
	media-libs/libwebp
	media-libs/mesa
	virtual/opengl
	x11-libs/cairo[glib]
	x11-libs/libxkbcommon
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-libs/wayland
	dev-util/wayland-scanner
	dev-libs/wayland-protocols
"
