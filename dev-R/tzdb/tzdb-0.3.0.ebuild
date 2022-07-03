# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit R-packages edo

DESCRIPTION="Time Zone Database Information"
KEYWORDS="~amd64"
LICENSE='MIT'
RESTRICT="!test? ( test )"
IUSE="test"

DEPEND="
	>=dev-R/cpp11-0.4.2
	test? (
		>=dev-R/testthat-3.0.0
	)
"

SUGGESTED_PACKAGES="
	dev-R/covr
	>=dev-R/testthat-3.0.0
"

src_test() {
	cd "${WORKDIR}/${P}/tests" || die
	NOT_CRAN=true R_LIBS="${T}/R" edo Rscript --vanilla testthat.R
}
