# Copyright 2022-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="User for signald"

ACCT_USER_ID=-1
ACCT_USER_GROUPS=( ${PN} )
ACCT_USER_HOME=/var/lib/signald
ACCT_USER_HOME_PERMS=0750

acct-user_add_deps
