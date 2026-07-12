# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RUST_MIN_VER="1.89.0"

inherit cargo desktop systemd xdg

DESCRIPTION="Native Wayland RDP server for GNOME, KDE, Sway and Hyprland (H.264, VA-API)"
HOMEPAGE="https://lamco.ai/ https://github.com/lamco-admin/lamco-rdp-server"
SRC_URI="https://github.com/lamco-admin/${PN}/releases/download/v${PV}/${P}.tar.xz"

# Business Source License 1.1 (source-available; converts to Apache-2.0 on the
# change date). The release tarball vendors every crate under vendor/ with a
# .cargo/config.toml, so the build is fully offline and CRATES is unused.
LICENSE="BUSL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="+gui +pam +vaapi"

RDEPEND="
	dev-libs/libei
	media-video/pipewire
	sys-apps/dbus
	sys-apps/xdg-desktop-portal
	sys-fs/fuse:3
	x11-libs/libxkbcommon
	pam? ( sys-libs/pam )
	vaapi? ( media-libs/libva )
	gui? ( media-libs/vulkan-loader )
"
DEPEND="${RDEPEND}"
BDEPEND="
	llvm-core/clang
	dev-build/cmake
	dev-lang/nasm
	virtual/pkgconfig
"
# Soft runtime helpers: Cisco OpenH264 for software H.264, wl-clipboard for the
# Linux->Windows clipboard path.
PDEPEND="
	media-libs/openh264
	gui-apps/wl-clipboard
"

# libva >= 2.22 added fields to VAEncPictureParameterBufferVP9 that the vendored
# cros-libva 0.0.13 does not know about; add ..Default::default() so it compiles.
PATCHES=( "${FILESDIR}/cros-libva-vp9-compat.patch" )

src_unpack() {
	# The tarball already carries vendor/ and .cargo/config.toml, so use a plain
	# unpack rather than cargo_src_unpack (which is for CRATES-fetched builds).
	default
}

src_prepare() {
	default
	# The patch above edits a vendored crate; clear its recorded checksum so the
	# --frozen/--offline cargo build does not reject the modified file.
	sed -i 's/"files":{[^}]*}/"files":{}/' vendor/cros-libva/.cargo-checksum.json || die
}

src_compile() {
	local features="h264,wayland,libei,wl-clipboard"
	use gui && features+=",gui"
	use pam && features+=",pam-auth"
	use vaapi && features+=",vaapi"

	# rust-lld (Rust >= 1.93 default) can't link the bundled native C libraries
	# (aws-lc-sys, ring, opus); force the system cc linker. Thin LTO + 4 codegen
	# units keep peak memory near 4GB (fat LTO peaks 8-10GB over ~900 crates).
	CARGO_HOME="${T}/cargo" \
	RUSTFLAGS="-C linker=cc ${RUSTFLAGS}" \
	CARGO_PROFILE_RELEASE_LTO=thin \
	CARGO_PROFILE_RELEASE_CODEGEN_UNITS=4 \
	cargo build --release --frozen --offline \
		--no-default-features --features "${features}" || die "cargo build failed"
}

src_install() {
	dobin target/release/lamco-rdp-server
	use gui && dobin target/release/lamco-rdp-server-gui

	systemd_douserunit packaging/systemd/lamco-rdp-server.service

	insinto /usr/share/dbus-1/services
	doins packaging/dbus/io.lamco.RdpServer.service
	insinto /etc/dbus-1/system.d
	doins packaging/dbus/io.lamco.RdpServer.System.conf
	insinto /usr/share/polkit-1/actions
	doins packaging/polkit/io.lamco.RdpServer.policy

	domenu data/io.lamco.rdp-server.desktop
	insinto /usr/share/metainfo
	doins data/io.lamco.rdp-server.metainfo.xml

	doicon -s scalable data/icons/io.lamco.rdp-server.svg
	local s
	for s in 32 48 64 128 256; do
		newicon -s "${s}" "data/icons/io.lamco.rdp-server-${s}.png" io.lamco.rdp-server.png
	done
}
