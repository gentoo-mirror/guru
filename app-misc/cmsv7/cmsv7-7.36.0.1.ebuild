# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

RPM_COMPRESS_TYPE="xz"

inherit rpm

DESCRIPTION="A vehicle monitoring and management platform"
HOMEPAGE="https://www.cmsv7.com"

SRC_URI="
	amd64? (
		https://www.cmsv7.com/cmssoft/CMSV7_LINUX(AMD64)_${PV}_260327.rpm
	)
"

S=${WORKDIR}
QA_PREBUILT="*"

LICENSE="babelstar"
SLOT="0"
KEYWORDS="-* ~amd64"

RESTRICT="mirror"

BDEPEND="
	app-arch/rpm
	app-arch/xz-utils
"

src_unpack() {
	rpm_src_unpack ${A}
}

src_install()
{
	cp -a opt usr "${ED}/" || die "Failed to copy installation files"
}
