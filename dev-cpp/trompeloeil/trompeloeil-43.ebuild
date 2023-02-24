# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Header only C++14 mocking framework"
HOMEPAGE="https://github.com/rollbear/trompeloeil"
SRC_URI="https://github.com/rollbear/trompeloeil/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"
