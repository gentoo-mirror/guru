# Copyright 2020-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Implementation of the olm and megolm cryptographic ratchets"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm"
SRC_URI="https://gitlab.matrix.org/matrix-org/${PN}/-/archive/${PV}/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

IUSE="test"
RESTRICT="!test? ( test )"

DOCS=( README.md docs )

src_configure() {
	local mycmakeargs=(
		-DOLM_TESTS=$(usex test)
	)

	cmake_src_configure
}

src_test() {
	local -x BUILD_DIR="${BUILD_DIR}/tests"
	cmake_src_test
}
