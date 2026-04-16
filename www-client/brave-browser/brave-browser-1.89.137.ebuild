# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar az bg bn ca cs da de el en-GB en-US es-419 es et fa fi fil fr
	gu he hi hr hu id it ja ka kk km kn ko lo lt lv mk ml mn mr ms my nb nl pl pt-BR
	pt-PT ro ru si sk sl sq sr-Latn sr sv sw ta te th tr uk ur uz vi zh-CN zh-TW"

inherit brave chromium-2 desktop pax-utils unpacker xdg

DESCRIPTION="The Brave Web Browser"
HOMEPAGE="https://brave.com/"

MY_PN="${PN}-stable"

SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/${PN}_${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="qt6 selinux"

RESTRICT="bindist mirror strip"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	app-misc/ca-certificates
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	>=dev-libs/nss-3.26
	media-fonts/liberation-fonts
	media-libs/alsa-lib
	media-libs/mesa[gbm(+)]
	net-misc/curl
	net-print/cups
	sys-apps/dbus
	sys-libs/glibc
	sys-libs/libcap
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	|| (
		x11-libs/gtk+:3[X]
		gui-libs/gtk:4[X]
	)
	x11-libs/libdrm
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb
	x11-libs/libxkbcommon
	x11-libs/libxshmfence
	x11-libs/pango
	x11-misc/xdg-utils
	qt6? ( dev-qt/qtbase:6[gui,widgets] )
	selinux? ( sec-policy/selinux-chromium )
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/brave-browser.*\.desktop"

BRAVE_HOME="/opt/brave.com/brave"

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	unpacker "${DISTDIR}/${PN}_${PV}_amd64.deb"
}

src_install() {
	cp -a "${WORKDIR}"/. "${ED}" || die

	if [[ -d "${ED}/usr/share/doc/${MY_PN}" ]]; then
		mv "${ED}/usr/share/doc/${MY_PN}" "${ED}/usr/share/doc/${PF}" || die
	fi

	if [[ -d "${ED}/usr/share/doc/${PN}" ]]; then
		rm -r "${ED}/usr/share/doc/${PN}" || die
	fi

	if [[ -f "${ED}/usr/share/doc/${PF}/changelog.gz" ]]; then
		gzip -d "${ED}/usr/share/doc/${PF}/changelog.gz" || die
	fi

	if [[ -d "${ED}/usr/share/appdata" ]]; then
		mv "${ED}/usr/share/appdata" "${ED}/usr/share/metainfo" || die
	fi

	if [[ -d "${ED}/etc/cron.daily" ]]; then
		rm -r "${ED}/etc/cron.daily" || die
	fi

	if [[ -d "${ED}${BRAVE_HOME}/cron" ]]; then
		rm -r "${ED}${BRAVE_HOME}/cron" || die
	fi

	if [[ -f "${ED}/usr/share/man/man1/${MY_PN}.1.gz" ]]; then
		gzip -d "${ED}/usr/share/man/man1/${MY_PN}.1.gz" || die
	fi

	if [[ -L "${ED}/usr/share/man/man1/${PN}.1.gz" ]]; then
		rm "${ED}/usr/share/man/man1/${PN}.1.gz" || die
		dosym "${MY_PN}.1" "/usr/share/man/man1/${PN}.1"
	fi

	if [[ -d "${ED}${BRAVE_HOME}/locales" ]]; then
		pushd "${ED}${BRAVE_HOME}/locales" > /dev/null || die
		chromium_remove_language_paks
		popd > /dev/null || die
	fi

	if [[ -d "${ED}${BRAVE_HOME}/resources/brave_extension/_locales" ]]; then
		pushd "${ED}${BRAVE_HOME}/resources/brave_extension/_locales" > /dev/null || die
		brave_remove_language_dirs
		popd > /dev/null || die
	fi

	if [[ -e "${ED}${BRAVE_HOME}/libqt5_shim.so" ]]; then
		rm "${ED}${BRAVE_HOME}/libqt5_shim.so" || die
	fi

	if ! use qt6 && [[ -e "${ED}${BRAVE_HOME}/libqt6_shim.so" ]]; then
		rm "${ED}${BRAVE_HOME}/libqt6_shim.so" || die
	fi

	local size icon_installed=0
	local suffix=${PN#*browser}
	suffix=${suffix//-/_}

	for size in 16 24 32 48 64 128 256; do
		if [[ -f "${ED}${BRAVE_HOME}/product_logo_${size}${suffix}.png" ]]; then
			newicon -s "${size}" "${ED}${BRAVE_HOME}/product_logo_${size}${suffix}.png" "${PN}.png"
			icon_installed=1
		elif [[ -f "${ED}${BRAVE_HOME}/product_logo_${size}.png" ]]; then
			newicon -s "${size}" "${ED}${BRAVE_HOME}/product_logo_${size}.png" "${PN}.png"
			icon_installed=1
		fi
	done
	[[ ${icon_installed} -eq 1 ]] || die "No program icons could be installed."

	pax-mark m "${ED}${BRAVE_HOME}/brave"
}
