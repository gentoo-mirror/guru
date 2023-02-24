# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit meson python-single-r1

DESCRIPTION="SU2: An Open-Source Suite for Multiphysics Simulation and Design"
HOMEPAGE="https://su2code.github.io/"
SRC_URI="
	https://github.com/su2code/SU2/archive/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/su2code/TestCases/archive/v${PV}.tar.gz -> ${P}-TestCases.tar.gz )
	tutorials? ( https://github.com/su2code/Tutorials/archive/v${PV}.tar.gz -> ${P}-Tutorials.tar.gz )
"

# SU2: LGPL-2.1; cgnslib: ZLIB, TecIO: all-rights-reserved;
# Metis: Apache-2.0; Parmetis: all-rights-reserved, free-noncomm; Mutationpp: LGPL-3.0.
LICENSE="Apache-2.0 LGPL-2.1 LGPL-3 ZLIB all-rights-reserved free-noncomm"
SLOT="0"
KEYWORDS="~amd64"

# metis, parmetis are bundled;
# omp is disable as it's experimental;
# pastix is disabled as it's require additional external bundled libs;
# autodiff (medi), directdiff (opti) features require additional external bundled libs.
IUSE="cgns mkl +mpi mpp openblas parmetis tecio test tutorials"

# Tests fail with FEATURES="network-sandbox" for most versions of openmpi and mpich it with error:
# "No network interfaces were found for out-of-band communications.
#  We require at least one available network for out-of-band messaging."
PROPERTIES="test_network"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	mkl? ( !openblas )
	parmetis? ( mpi )
	test? ( parmetis tutorials )
"

RDEPEND="
	${PYTHON_DEPS}
	cgns? ( >=sci-libs/cgnslib-4 )
	mkl? ( sci-libs/mkl )
	mpi? ( virtual/mpi[cxx] )
	mpp? ( sci-libs/Mutationpp:= )
	openblas? ( sci-libs/openblas )
"
DEPEND="
	${RDEPEND}
	dev-cpp/cli11:=
	tecio? ( >=dev-libs/boost-1.76.0:= )
	test? ( <dev-cpp/catch-3:0 )
"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/${PN}-7.0.4-unbundle_boost.patch"
	"${FILESDIR}/${PN}-7.1.0-fix-env.patch"
	"${FILESDIR}/${PN}-7.2.0-system-libraries.patch"
	"${FILESDIR}/${PN}-7.2.0-DESTDIR.patch"
	"${FILESDIR}/${PN}-7.2.0-fix-headers.patch"
)

DOCS=( "README.md" "SU2_PY/documentation.txt" )

src_unpack() {
	unpack "${P}.tar.gz"
	if use test ; then
		einfo "Unpacking ${P}-TestCases.tar.gz to /var/tmp/portage/sci-physics/${P}/work/${P}/TestCases"
		tar -C "${P}"/TestCases --strip-components=1 -xzf "${DISTDIR}/${P}-TestCases.tar.gz" || die
	fi
	if use tutorials ; then
		einfo "Unpacking ${P}-Tutorials.tar.gz to /var/tmp/portage/sci-physics/${P}/work/${P}"
		mkdir "${P}"/Tutorials || die
		tar -C "${P}"/Tutorials --strip-components=1 -xzf "${DISTDIR}/${P}-Tutorials.tar.gz" || die
	fi
}

src_prepare(){
	default

	rm -rf externals/{CLI11,autotools,catch2,cgns,codi,medi,meson,ninja,opdi} || die

	# boost Geometry requires c++14 since >=boost-1.75
	sed -i -e 's:cpp_std=c++11:cpp_std=c++14:' meson.build || die

	# Force Disable parmetis support in meson.build (configure.ac has optional switch)
	use !parmetis && { sed -i -e "/parmetis/Id" meson.build || die ; }

	# Disable python-wrapper tests
	sed -i "/append(pywrapper_/s/./#&/" TestCases/parallel_regression.py || die
	# Disable failed tests
	sed -i "/append(dyn_fsi/s/./#&/" TestCases/parallel_regression.py || die
	sed -i "/append(fd_sp_pinArray_cht_2d_dp_hf/s/./#&/" TestCases/parallel_regression.py || die

	# Copy absence mesh file
	if use test ; then
		cp "${S}/TestCases/nonequilibrium/viscwedge/viscwedge.su2" "${S}/TestCases/nonequilibrium/axi_visccone/" || die
	fi
}

src_configure() {
	if use mpi ; then
		export CC=mpicc
		export CXX=mpicxx
	fi

	local emesonargs=(
		-Denable-autodiff=false
		-Denable-directdiff=false
		-Denable-pastix=false
		-Denable-pywrapper=false
		-Dwith-omp=false
		$(meson_feature mpi with-mpi)
		$(meson_use mpi custom-mpi)
		$(meson_use cgns enable-cgns)
		$(meson_use mkl enable-mkl)
		$(meson_use mpp enable-mpp)
		$(meson_use openblas enable-openblas)
		$(meson_use tecio enable-tecio)
		$(meson_use test enable-tests)
	)
	meson_src_configure
}

src_test() {
	ln -s ../../${P}-build/SU2_CFD/src/SU2_CFD SU2_PY/SU2_CFD || die
	ln -s ../../${P}-build/SU2_DEF/src/SU2_DEF SU2_PY/SU2_DEF || die
	ln -s ../../${P}-build/SU2_DOT/src/SU2_DOT SU2_PY/SU2_DOT || die
	ln -s ../../${P}-build/SU2_GEO/src/SU2_GEO SU2_PY/SU2_GEO || die
	ln -s ../../${P}-build/SU2_SOL/src/SU2_SOL SU2_PY/SU2_SOL || die

	export SU2_RUN="${S}/SU2_PY"
	export SU2_HOME="${S}"
	export PATH="${PATH}:${SU2_RUN}"
	export PYTHONPATH="${PYTHONPATH}:${SU2_RUN}"

	einfo "Running UnitTests ..."
	../${P}-build/UnitTests/test_driver || die

	pushd TestCases/ || die
	if use mpi ; then
		if use tutorials ; then
			${EPYTHON} tutorials.py || die
		fi
		${EPYTHON} parallel_regression.py || die
	else
		${EPYTHON} serial_regression.py || die
	fi
	popd || die
}

src_install() {
	DESTDIR="${D}" meson_src_install

	mkdir -p "${D}$(python_get_sitedir)/SU2_PY" || die
	mv "${ED}"/usr/bin/{FSI_tools,SU2,SU2_Nastran} -t "${D}$(python_get_sitedir)" || die
	mv "${ED}"/usr/bin/*.py -t "${D}$(python_get_sitedir)/SU2_PY" || die
	python_optimize "${D}/$(python_get_sitedir)"

	if use tutorials ; then
		insinto "/usr/share/${PN}"
		doins -r Tutorials
	fi

	local SU2_RUN="$(python_get_sitedir)/SU2_PY"
	echo SU2_RUN="${SU2_RUN}" > 99SU2
	echo PATH="${SU2_RUN}" >> 99SU2
	echo PYTHONPATH="${SU2_RUN}" >> 99SU2

	doenvd 99SU2
}
