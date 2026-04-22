<!--
Copyright 2026 Gentoo Authors
Distributed under the terms of the GNU General Public License v2
-->
<!--use go-md2man to generate man pages-->
geteduroam-gui 1 "April 2026" "geteduroam-gui 0.14" "Geteduroam"
==============================================================

# NAME
geteduroam-gui - GTK interface for the geteduroam utility

# SYNOPSIS
**geteduroam-gui** \[options\]

**geteduroam-gui** --help | -h | --version

# DESCRIPTION
**geteduroam-gui** is a GTK interface to make eduroam connection profiles for NetworkManager. It requires a network connection, because it needs to authorize via MicroSoft to generate the eduroam certificates. **geteduroam-gui** puts its files in _~/.local/share/geteduroam_.

# OPTIONS

**-h** and **--help** display a basic help message and exit.

**--version** print version number and exit.

**-d** and **--debug** enable debug mode.

**--gtk-args** arguments that get passed to GTK as a string, e.g. "--help". These flags are split on spaces.
