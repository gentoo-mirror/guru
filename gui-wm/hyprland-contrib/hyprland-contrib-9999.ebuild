# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3
EGIT_REPO_URI="https://github.com/hyprwm/contrib.git"

DESCRIPTION="Community scripts and utilities for Hypr projects"
HOMEPAGE="https://github.com/hyprwm/contrib"

RDEPEND="
	app-shells/bash
	gui-wm/hyprland
	grimblast? (
		gui-apps/wl-clipboard
		gui-apps/grim
		gui-apps/slurp
		app-misc/jq
	)
	hyprprop? (
		app-misc/jq
		gui-apps/slurp
	)
	scratchpad? (
		sys-apps/sed
		gui-apps/slurp
		app-misc/jq
	)
"
BDEPEND="
	grimblast? (
		app-text/scdoc
	)
	hyprprop? (
		app-text/scdoc
	)
"
DEPEND="${RDEPEND}"

LICENSE="MIT"
SLOT="0"
IUSE="grimblast scratchpad shellevents hyprprop swap"
REQUIRED_USE="|| ( grimblast scratchpad shellevents hyprprop swap )"

src_install() {
    if use grimblast; then
	   pushd grimblast || die
	   PREFIX="${D}/usr" emake install
	   popd || die
    fi

    if use scratchpad; then
	   pushd scratchpad || die
	   PREFIX="${D}/usr" emake install
	   popd || die
    fi
    
    if use shellevents; then
	   pushd shellevents || die
	   PREFIX="${D}/usr" emake install
	   popd || die
    fi
    
    if use hyprprop; then
	   pushd hyprprop || die
	   PREFIX="${D}/usr" emake install
	   popd || die
    fi

    if use swap; then
	   pushd try_swap_workspace || die
	   PREFIX="${D}/usr" emake install
	   popd || die
    fi
    
}

pkg_postinst() {
	if use grimblast || use hyprprop || use scratchpad || use swap; then
		optfeature "GUI notifications during dependency checks" x11-libs/libnotify
	fi
}
