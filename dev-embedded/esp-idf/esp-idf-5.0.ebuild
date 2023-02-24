# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..10} )

VER="esp-2022r1"
CROSSTOOL_URL="https://github.com/espressif/crosstool-NG/releases/download/${VER}"

inherit python-single-r1

DESCRIPTION="Espressif IoT Development Framework"
HOMEPAGE="https://www.espressif.com/"

#	https://github.com/espressif/binutils-esp32ulp/releases/download/v2.28.51-esp-20191205/binutils-esp32ulp-linux-amd64-2.28.51-esp-20191205.tar.gz
SRC_URI="https://dl.espressif.com/github_assets/espressif/${PN}/releases/download/v${PV}/${PN}-v${PV}.zip -> ${P}.zip
	https://github.com/espressif/openocd-esp32/releases/download/v0.11.0-esp32-20221026/openocd-esp32-linux-amd64-0.11.0-esp32-20221026.tar.gz
	${CROSSTOOL_URL}/xtensa-esp32-elf-gcc11_2_0-${VER}-linux-amd64.tar.xz
	${CROSSTOOL_URL}/xtensa-esp32s2-elf-gcc11_2_0-${VER}-linux-amd64.tar.xz
	${CROSSTOOL_URL}/xtensa-esp32s3-elf-gcc11_2_0-${VER}-linux-amd64.tar.xz
	${CROSSTOOL_URL}/riscv32-esp-elf-gcc11_2_0-${VER}-linux-amd64.tar.xz
"
#https://dl.espressif.com/dl/toolchains/preview/riscv32-esp-elf-gcc8_4_0-crosstool-ng-1.24.0-123-g64eb9ff-linux-amd64.tar.gz

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
IUSE="+esp32 esp32s2 esp32s3 riscv32"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

SLOT="0"

RDEPEND="
	${PYTHON_DEPS}
	dev-embedded/esptool[${PYTHON_SINGLE_USEDEP}]

	$(python_gen_cond_dep '
		dev-python/click[${PYTHON_USEDEP}]
		dev-python/bitstring[${PYTHON_USEDEP}]
		dev-python/construct[${PYTHON_USEDEP}]
		dev-python/ecdsa[${PYTHON_USEDEP}]
		dev-python/future[${PYTHON_USEDEP}]
		dev-python/kconfiglib[${PYTHON_USEDEP}]
		dev-python/pyelftools[${PYTHON_USEDEP}]
		dev-python/pyparsing[${PYTHON_USEDEP}]
		dev-python/pyserial[${PYTHON_USEDEP}]
		dev-python/python-socketio[${PYTHON_USEDEP}]
		dev-python/pyyaml[${PYTHON_USEDEP}]
		dev-python/reedsolomon[${PYTHON_USEDEP}]
		dev-embedded/idf-component-manager[${PYTHON_USEDEP}]
	')
"

RESTRICT="strip"

QA_PREBUILT="opt/* usr/lib* usr/share/esp-idf/*"
QA_PRESTRIPPED="opt/*"

PATCHES=("${FILESDIR}/allow-system-install-${P}.patch")

S="${WORKDIR}/${PN}-v${PV}"

install_tool() {
	shopt -s globstar

	into /opt/${1}

	if [[ -d "../${1}/lib" ]]; then
		if stat *.so &>/dev/null; then
		for i in ../${1}/lib/**/*.so*; do
			dolib.so ${i}
		done
		fi

		if stat *.a &>/dev/null; then
		for i in ../${1}/lib/**/*.a*; do
			dolib.a ${i}
		done
		fi

		insinto /opt/${1}/lib
		doins -r ../${1}/lib/*
	fi

	exeinto /opt/${1}/bin
	doexe ../${1}/bin/*
	(
	cd ../${1}
	for i in libexec/**/*; do
		exeinto /opt/${1}/$(dirname ${i})
		if [[ -x "${i}" && ! -d "${i}" ]]; then
			doexe ${i}
		fi
	done

	if [[ -d "include" ]]; then
		insinto /opt/${1}
		doins -r include
	fi

	if [[ -d "share" ]]; then
		insinto /opt/${1}
		doins -r share
	fi
	)

	(
		cd "${D}"/opt/${1}/bin/ || die
		for i in *; do
			dodir /opt/bin
			cd "${D}"/opt/bin || die
			dosym ../${1}/bin/${i} /opt/bin/${i}
		done
	)
}

src_install() {
	echo -e "#!/bin/sh\npython /usr/share/${PN}/tools/idf.py \"\$@\"" > idf
	dobin idf

	if use esp32; then
		install_tool xtensa-esp32-elf
		install_tool xtensa-esp32-elf/xtensa-esp32-elf
	fi

	if use esp32s2; then
		install_tool xtensa-esp32s2-elf
	fi

	if use esp32s3; then
		install_tool xtensa-esp32s3-elf
	fi

	if use riscv32; then
		install_tool riscv32-esp-elf
	fi
	install_tool openocd-esp32

	echo "IDF_PATH=/usr/share/${PN}" > 99esp-idf || die
	doenvd 99esp-idf

	insinto /usr/share/${PN}

	rm -r .git || die
	doins -r .
}
