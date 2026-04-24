<!--
Copyright 2026 Gentoo Authors
Distributed under the terms of the GNU General Public License v2
-->
<!--use go-md2man to generate man pages-->
geteduroam-cli 1 "April 2026" "geteduroam-cli 0.14" "Geteduroam"
==============================================================

# NAME
geteduroam-notifcheck - Checks if eduroam certificates are still validte

# SYNOPSIS
**geteduroam-cli** \[-h | --help\]

# DESCRIPTION
**geteduroam-notifcheck** checks if the eduroam connection profile are still valid. If they expire within ten days it will send a message via notify-send(1). It provides a systemd user service to automate this on a daily basis.

# OPTIONS

**-h** and **--help** display a basic help message and exit.
