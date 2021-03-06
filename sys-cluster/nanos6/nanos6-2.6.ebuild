# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="runtime that implements the OmpSs-2 parallel programming model"
HOMEPAGE="https://github.com/bsc-pm/nanos6"
SRC_URI="https://github.com/bsc-pm/nanos6/archive/refs/tags/version-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-version-${PV}"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cluster debug dlb execution-workflow extrae memkind papi unwind"
#chrono-arch build fail
#jemalloc require custom stuff
#TODO: cuda pqos mercurium k1om babeltrace2
#TODO: llvm-libunwind

RDEPEND="
	>=dev-libs/boost-1.59:=
	sys-apps/hwloc
	sys-process/numactl
	virtual/libelf

	cluster? ( virtual/mpi )
	dlb? ( sys-cluster/dlb )
	extrae? ( sys-cluster/extrae[nanos] )
	memkind? ( dev-libs/memkind )
	papi? ( dev-libs/papi )
	unwind? ( sys-libs/libunwind )
"
DEPEND="${RDEPEND}"
REQUIRED_USE="cluster? ( execution-workflow )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-embed-code-changes
		--disable-openacc
		--disable-static

		--enable-shared

		--with-boost="${EPREFIX}/usr"
		--with-libnuma="${EPREFIX}/usr"
		--with-pic

		--without-git
		--without-k1om
		--without-nanos6-clang
		--without-nanos6-mercurium
		--without-pgi

		$(use_enable cluster)
		$(use_enable debug extra-debug)
		$(use_enable execution-workflow)
	)
	use dlb && myconf+=( "--with-dlb=${EPREFIX}/usr" )
	use memkind && myconf+=( "--with-memkind=${EPREFIX}/usr" )

#	if use babeltrace; then
#		myconf+=( "--with-babeltrace2=${EPREFIX}/usr" )
#	else
#		myconf+=( "--without-babeltrace2" )
#	fi
	if use extrae; then
		myconf+=( "--with-extrae=${EPREFIX}/usr" )
	else
		myconf+=( "--without-extrae" )
	fi
	if use papi; then
		myconf+=( "--with-papi=${EPREFIX}/usr" )
	else
		myconf+=( "--without-papi" )
	fi
	if use unwind; then
		myconf+=( "--with-libunwind=${EPREFIX}/usr" )
	else
		myconf+=( "--without-libunwind" )
	fi

	econf "${myconf[@]}"
}
#		--without-pqos
#		--without-cuda

src_install() {
	default
	dodoc CHANGELOG.md
	rm -r docs/Doxyfile* || die
	dodoc -r docs/.

	docompress -x "/usr/share/doc/${PF}/paraver-cfg"
	docompress -x "/usr/share/doc/${PF}/scripts"
}

pkg_postinst() {
	elog "install media-gfx/graphviz and app-text/pdfjam or >=app-text/texlive-core-2021 to generate graphical representations of the dependency graph"
	elog "install sys-process/parallel to generate the graph representation in parallel"
}
