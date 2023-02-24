# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Simple terminal UI for git commands"
HOMEPAGE="https://github.com/jesseduffield/lazygit"
SRC_URI="https://github.com/jesseduffield/${PN}/archive/v${PV}.0.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 BSD ISC MIT Unlicense"
SLOT="0"
KEYWORDS="~amd64"

S="${WORKDIR}/${P}.0"

RDEPEND="dev-vcs/git"

DOCS=( {CODE-OF-CONDUCT,CONTRIBUTING,README}.md docs )

src_compile() {
	go build -o bin/lazygit || die
}

src_install() {
	dobin bin/lazygit
	einstalldocs
}
