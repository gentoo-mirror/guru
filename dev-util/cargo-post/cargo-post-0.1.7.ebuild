# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.3

EAPI=8

CRATES="
	cargo_metadata@0.7.4
	error-chain@0.12.2
	itoa@0.4.5
	proc-macro2@1.0.17
	quote@1.0.6
	ryu@1.0.4
	semver-parser@0.7.0
	semver@0.9.0
	serde@1.0.110
	serde_derive@1.0.110
	serde_json@1.0.53
	syn@1.0.25
	toml@0.5.6
	unicode-xid@0.2.0
	version_check@0.9.2
"

inherit cargo

DESCRIPTION="A cargo wrapper that executes a post build script after a successful build."
HOMEPAGE="https://github.com/phil-opp/cargo-post"
SRC_URI="
	https://github.com/phil-opp/cargo-post/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="|| ( Apache-2.0 MIT )"
# Dependent crate licenses
LICENSE+="
	MIT
	|| ( Apache-2.0 Boost-1.0 )
"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/cargo-post"

src_install() {
	cargo_src_install
	local DOCS="Changelog.md Readme.md"
	einstalldocs
}
