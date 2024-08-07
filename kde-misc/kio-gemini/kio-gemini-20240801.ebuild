# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="8799b660de21993b2e0804066566b3dafd483215"
ECM_HANDBOOK="forceoptional"
KFMIN=5.98.0
QTMIN=5.4.0
inherit ecm

DESCRIPTION="Gemini KIO worker"
HOMEPAGE="https://gitlab.com/tobiasrautenkranz/kio-gemini"
SRC_URI="https://gitlab.com/tobiasrautenkranz/${PN}/-/archive/${COMMIT}/${PN}-${COMMIT}.tar.bz2"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="LGPL-2+"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~x86"

DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kio-${KFMIN}:5
	>=kde-frameworks/kservice-${KFMIN}:5
"
RDEPEND="${DEPEND}"
