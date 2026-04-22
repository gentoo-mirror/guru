<!--
Copyright 2026 Gentoo Authors
Distributed under the terms of the GNU General Public License v2
-->
<!--use go-md2man to generate man pages-->
geteduroam-cli 1 "April 2026" "geteduroam-cli 0.14" "Geteduroam"
==============================================================

# NAME
geteduroam-cli - CLI interface for the geteduroam utility

# SYNOPSIS
**geteduroam-cli** \[options\]

**geteduroam-cli** --help | -h | --version

# DESCRIPTION
**geteduroam-cli** is a CLI interface to make eduroam connection profiles for NetworkManager. It requires a network connection, because it needs to authorize via MicroSoft to generate the eduroam certificates. **geteduroam-cli** puts its files in _~/.local/share/geteduroam_.

# OPTIONS

**-h** and **--help** display a basic help message and exit.

**--version** print version number and exit.

**-v** enable verbose mode.

**-d** and **--debug** enable debug mode.

**-l** _/path/to/file_ and **--local**=_/path/to/file_ the path to a local EAP metadata file. <!--upstream help message, what ever it means-->

**-u** _url_ and **--url**=_url_ the URL where an EAP metadata file or Let's Wifi portal is hosted. <!--from upstream help message-->
