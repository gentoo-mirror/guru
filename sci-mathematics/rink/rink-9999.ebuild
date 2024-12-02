# Copyright 2024 demize
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.3

EAPI=8

inherit cargo desktop git-r3

DESCRIPTION="Unit conversion tool, similar to frink"
HOMEPAGE="https://rinkcalc.app/about"
EGIT_REPO_URI="https://github.com/tiffany352/rink-rs.git"

LICENSE="MPL-2.0"
# Dependent crate licenses
# owo-colors is MIT but notated as LICENCE
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 MIT MPL-2.0 Unicode-DFS-2016
"

SLOT="0"
IUSE="doc"

DEPEND+="
	net-misc/curl
	dev-libs/openssl
	sys-libs/zlib
"
BDEPEND+="dev-ruby/asciidoctor"
RDEPEND+="net-misc/curl"

QA_FLAGS_IGNORED="usr/bin/rink"

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_configure() {
	# RINK_PATH is used in the build process to define the data file location
	export RINK_PATH=/usr/share/rink
	cargo_src_configure --no-default-features
}

src_test() {
	local tests_skip=(
		# requires bundled files, which are disabled in this ebuild
		--skip test_to_ansi
	)
}

src_install() {
	cargo_src_install --path cli

	insinto /usr/share/rink
	doins core/definitions.units
	doins core/currency.units
	doins core/datepatterns.txt

	newicon -s 192 "${S}/web/site/images/icons/icon-192x192.png" rink.png
	newicon -s 512 "${S}/web/site/images/icons/icon-512x512.png" rink.png
	domenu "cli/rink.desktop"

	make man
	doman build/rink.1
	doman build/rink.5
	doman build/rink.7
	doman build/rink-defs.5
	doman build/rink-dates.5

	if use doc; then
		make htmldoc
		local DOCS=( README.md )
		local HTML_DOCS=(
			build/rink.1.html
			build/rink.5.html
			build/rink.7.html
			build/rink-defs.5.html
			build/rink-dates.5.html
		)
		einstalldocs
	fi
}
