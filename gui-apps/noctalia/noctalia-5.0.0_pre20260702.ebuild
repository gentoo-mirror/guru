# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson optfeature xdg-utils

MY_COMMIT="8d2c6881d3e1e7f1e894fc2e811c36fe9ffa6989"

DESCRIPTION="A lightweight Wayland shell and bar built directly on Wayland + OpenGL ES"
HOMEPAGE="https://noctalia.dev/ https://github.com/noctalia-dev/noctalia"

SRC_URI="https://github.com/noctalia-dev/noctalia/archive/${MY_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${MY_COMMIT}"

LICENSE="MIT"
SLOT="0"

IUSE="+jemalloc"

DEPEND="
	dev-cpp/sdbus-c++
	dev-libs/glib:2
	jemalloc? ( dev-libs/jemalloc:= )
	dev-libs/libxml2
	dev-libs/wayland
	gnome-base/librsvg:2
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libwebp
	media-libs/mesa
	media-video/pipewire
	net-misc/curl
	sci-libs/libqalculate
	sys-auth/polkit
	sys-libs/pam
	virtual/opengl
	x11-libs/cairo[glib]
	x11-libs/libxkbcommon
	x11-libs/pango
	dev-cpp/tomlplusplus
	dev-libs/md4c
"

RDEPEND="${DEPEND}"

BDEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	dev-util/wayland-scanner
"

DOCS=( README.md CREDITS.md example.toml )

src_configure() {
	local emesonargs=(
		$(meson_feature jemalloc)
		-Dsystem_md4c=true
		-Dsystem_tomlplusplus=true
	)
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	optfeature "external display brightness control" app-misc/ddcutil
	optfeature "hardware-accelerated screen recording" media-video/gpu-screen-recorder
}
