# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

declare -g -r -A ZBS_DEPENDENCIES=(
	[xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.3.0.tar.gz'
	[xkbcommon-0.4.0-VDqIe0i2AgDRsok2GpMFYJ8SVhQS10_PI2M_CnHXsJJZ.tar.gz]='https://codeberg.org/ifreund/zig-xkbcommon/archive/v0.4.0.tar.gz'
	[wayland-0.5.0-lQa1knz8AQCh08NA8BeQrwJB9U3CfqcVAdHZYGRKIGuu.tar.gz]='https://codeberg.org/ifreund/zig-wayland/archive/v0.5.0.tar.gz'
	[mvzr-0.3.7-ZSOky5FtAQB2VrFQPNbXHQCFJxWTMAYEK7ljYEaMR6jt.tar.gz]='https://github.com/mnemnion/mvzr/archive/refs/tags/v0.3.7.tar.gz'
	[mvzr-0.3.7-ZSOky1dvAQDTEE_8S0pvpasmoEWQHVA29tMBdxL_hwra.tar.gz]='https://github.com/mnemnion/mvzr/archive/refs/tags/v0.3.8.tar.gz'
	[fcft-2.0.0-zcx6C5EaAADIEaQzDg5D4UvFFMjSEwDE38vdE9xObeN9.tar.gz]='https://git.sr.ht/~novakane/zig-fcft/archive/v2.0.0.tar.gz'
	[pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX.tar.gz]='https://codeberg.org/ifreund/zig-pixman/archive/v0.3.0.tar.gz'
	[kwim-0.1.4-Ewp5Gx_UAgD84P2X7z3_sv96iQjX21bxMenSp4wv8GRZ.tar.gz]='https://github.com/kewuaa/kwim/archive/refs/tags/v0.1.4.tar.gz'
	[clap-0.11.0-oBajB-HnAQDPCKYzwF7rO3qDFwRcD39Q0DALlTSz5H7e.tar.gz]='https://github.com/Hejsil/zig-clap/archive/refs/tags/0.11.0.tar.gz'
)
ZIG_SLOT="0.15"

inherit zig

DESCRIPTION="A window manager based on River Wayland compositor"
HOMEPAGE="https://github.com/kewuaa/kwm"
SRC_URI="
	https://github.com/kewuaa/kwm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${ZBS_DEPENDENCIES_SRC_URI}
"

# kwm: GPL-3
# all dependencies: MIT
LICENSE="GPL-3 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+bar"

DEPEND="
	dev-libs/wayland
	x11-libs/libxkbcommon
	x11-libs/pixman
	bar? ( media-libs/fcft )
"
RDEPEND="${DEPEND}"

src_configure() {
	local my_zbs_args=(
		-Dbar=$(usex bar true false)

		# make sure build.zig can pick up default config, must be a relative path
		-Dconfig="../${P}/config.def.zon"
	)

	zig_src_configure
}

src_install() {
	zig_src_install
	rm -r "${ED}/usr/share/doc/kwm/" || die "rm failed"
}
