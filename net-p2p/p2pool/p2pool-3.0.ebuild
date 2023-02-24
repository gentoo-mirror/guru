# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

P2POOL_DIST_COMMIT="e64a0acfb37961e0a3b185a6de04ab92bacbbf24"
	RANDOMX_DIST_COMMIT="58c3943ff5699ebd36e178b8d4c6183bcb82419c"
	CPPZMQ_DIST_COMMIT="c66fc6094b2a03439dea8469719e221e80e2e8e7"
	CURL_DIST_COMMIT="c12fb3ddaf48e709a7a4deaa55ec485e4df163ee"
	LIBUV_DIST_COMMIT="55077af4b50e13c5b7c02131ff16695685478fc8"
	RAPIDJSON_DIST_COMMIT="914b772dfda5301dfa94309a114b207c67720d68"
	ROBIN_HOOD_HASHING_DIST_COMMIT="4213dd109f03b49c68b52074d929e6f221803bed"

DESCRIPTION="Decentralized pool for Monero mining"
HOMEPAGE="https://p2pool.io"

SRC_URI="
	https://github.com/SChernykh/p2pool/archive/${P2POOL_DIST_COMMIT}.tar.gz -> \
${P}.tar.gz
	https://github.com/tevador/RandomX/archive/${RANDOMX_DIST_COMMIT}.tar.gz -> \
${P}-randomx.tar.gz
	https://github.com/SChernykh/cppzmq/archive/${CPPZMQ_DIST_COMMIT}.tar.gz -> \
${P}-cppzmq.tar.gz
	https://github.com/SChernykh/curl/archive/${CURL_DIST_COMMIT}.tar.gz -> \
${P}-curl.tar.gz
	https://github.com/SChernykh/libuv/archive/${LIBUV_DIST_COMMIT}.tar.gz -> \
${P}-libuv.tar.gz
	https://github.com/SChernykh/rapidjson/archive/${RAPIDJSON_DIST_COMMIT}.tar.gz -> \
${P}-rapidjson.tar.gz
	https://github.com/SChernykh/robin-hood-hashing/archive/${ROBIN_HOOD_HASHING_DIST_COMMIT}.tar.gz -> \
${P}-robin-hood-hashing.tar.gz
"
KEYWORDS="~amd64 ~arm64 ~x86"

LICENSE="BSD GPL-3+ ISC LGPL-3+ MIT"
SLOT="0"

DEPEND="
	dev-libs/libsodium
	net-libs/czmq
"

src_unpack() {
	unpack ${P}.tar.gz \
		${P}-randomx.tar.gz \
		${P}-cppzmq.tar.gz \
		${P}-curl.tar.gz \
		${P}-libuv.tar.gz \
		${P}-rapidjson.tar.gz \
		${P}-robin-hood-hashing.tar.gz
	mv -T "${WORKDIR}"/p2pool-${P2POOL_DIST_COMMIT} \
		"${WORKDIR}"/${P} || die
	mv -T "${WORKDIR}"/RandomX-${RANDOMX_DIST_COMMIT} \
		"${WORKDIR}"/${P}/external/src/RandomX || die
	mv -T "${WORKDIR}"/cppzmq-${CPPZMQ_DIST_COMMIT} \
		"${WORKDIR}"/${P}/external/src/cppzmq || die
	mv -T "${WORKDIR}"/curl-${CURL_DIST_COMMIT} \
		"${WORKDIR}"/${P}/external/src/curl || die
	mv -T "${WORKDIR}"/libuv-${LIBUV_DIST_COMMIT} \
		"${WORKDIR}"/${P}/external/src/libuv || die
	mv -T "${WORKDIR}"/rapidjson-${RAPIDJSON_DIST_COMMIT} \
		"${WORKDIR}"/${P}/external/src/rapidjson || die
	mv -T "${WORKDIR}"/robin-hood-hashing-${ROBIN_HOOD_HASHING_DIST_COMMIT} \
		"${WORKDIR}"/${P}/external/src/robin-hood-hashing || die
}

src_prepare() {
	default

	# Stop their script from overriding flags:
	cp "${FILESDIR}"/flags.cmake cmake/flags.cmake || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DWITH_RANDOMX=OFF
	)

	cmake_src_configure
}

src_install(){
	dobin "${BUILD_DIR}/p2pool"
}

pkg_postinst() {
	#Some important wisdom taken from P2Pool documentation
	ewarn "P2Pool for Monero is now installed."
	ewarn "You can run it by doing 'p2pool --host 127.0.0.1 --wallet YOUR_PRIMARY_ADDRESS'"
	ewarn "Where 127.0.0.1 is the address of a local monero node (e.g. monerod)"
	ewarn ""
	ewarn "Once configured, point your RandomX miner (e.g. XMRig) at p2pool"
	ewarn "For example 'xmrig -o 127.0.0.1:3333'"
	ewarn ""
	ewarn "You MUST use your primary address when using p2pool, just like solo mining."
	ewarn "If you want privacy, create a new mainnet wallet for P2Pool mining."
	ewarn ""
	ewarn "Rewards will not be visibile unless you use a wallet that supports P2Pool."
	ewarn "See https://p2pool.io/#help and https://github.com/SChernykh/p2pool for more information."
}
