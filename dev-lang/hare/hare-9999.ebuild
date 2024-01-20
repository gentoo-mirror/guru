# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ "${PV}" = 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.sr.ht/~sircmpwn/hare"
	SLOT="0"
else
	EGIT_COMMIT="29fbde4fe95db7da3ee54882f3a29a10aea53b8d"
	MY_P="${PN}-${EGIT_COMMIT}"
	SRC_URI="https://git.sr.ht/~sircmpwn/hare/archive/${EGIT_COMMIT}.tar.gz -> ${MY_P}.tar.gz"
	S="${WORKDIR}/${MY_P}"
	SLOT="0/${PV}"
	KEYWORDS="~amd64 ~arm64 ~riscv"
fi

DESCRIPTION="The Hare systems programming language"
HOMEPAGE="https://harelang.org/"
LICENSE="MPL-2.0 GPL-3"

DEPEND="
	~dev-lang/harec-9999
	~sys-devel/qbe-9999
"
BDEPEND="app-text/scdoc"
RDEPEND="${DEPEND}"

# hare and haredoc are built by hare
QA_FLAGS_IGNORED="usr/bin/hare usr/bin/haredoc"

src_configure() {
	local target_arch
	case ${ARCH} in
		amd64 ) target_arch=x86_64 ;;
		arm64 ) target_arch=aarch64 ;;
		riscv ) target_arch=riscv64 ;;
		* ) die "unsupported architecture: ${ARCH}" ;;
	esac

	# Note: PREFIX needs to be set early as it is used for HAREPATH
	cp configs/linux.mk config.mk || die
	sed -i \
		-e "s;^ARCH =.*;ARCH = ${target_arch};" \
		-e "s;^PREFIX =.*;PREFIX = ${EPREFIX}/usr;" \
		-e 's;^AS =;AS ?=;' \
		-e 's;^LD =;LD ?=;' \
		config.mk || die
}

src_install() {
	emake DESTDIR="${D}" install
}
