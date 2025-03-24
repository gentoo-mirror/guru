<p align="center">
<img src="guru.svg" alt="logo">
</p>

# The GURU Project Repository

[![pkgcheck](https://github.com/gentoo/guru/actions/workflows/pkgcheck.yml/badge.svg)](https://github.com/gentoo/guru/actions?query=workflow%3Apkgcheck)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](https://wiki.gentoo.org/wiki/Project:GURU/Information_for_Contributors)
[![chat on libera](https://img.shields.io/badge/chat-on%20libera-brightgreen.svg)](https://web.libera.chat/#gentoo-guru)

<table><tr>
<td width="68%">

**The official repository for new Gentoo packages, maintained collaboratively by Gentoo users.**

This README contains some additional useful information for GURU contributors, such as common mistakes, frequently asked questions and other tips and tricks.

The [GURU regulations](https://wiki.gentoo.org/wiki/Project:GURU#The_regulations), and the Gentoo [developer manual](https://devmanual.gentoo.org/) take precedence over any information here.

*See [wiki.gentoo.org/wiki/Project:GURU](https://wiki.gentoo.org/wiki/Project:GURU) for more information on the project.*

</td>
<td width="27%" style="border-style:solid; border-radius:10px;">

### Contents

1. [Installation](#install)
  - [Eselect](#install-eselect)
  - [Manual](#install-manual)
  - [Layman](#install-layman)
2. [Useful Links](#links)
3. [Email Addresses](#email)

</td>
</tr></table>

## Installation <a name="install"></a>

As per the current [Portage specification](https://dev.gentoo.org/~zmedico/portage/doc/man/portage.5.html), ebuild repositories (a.k.a. overlays) can be managed via file collections under `/etc/portage/repos.conf/`, via the new [plug-in sync system](https://wiki.gentoo.org/wiki/Project:Portage/Sync).

### Eselect-repository Install <a name="install-eselect"></a>

The overlay can be enabled via the `repository` extension of the Gentoo `eselect` utility.

```console
emerge --ask --noreplace --verbose eselect-repository
eselect repository enable guru
```

### Eselect-repository Uninstall

To disable and remove the overlay, run:

```console
eselect repository disable guru
eselect repository remove guru
```

### Manual Install <a name="install-manual"></a>

To enable the overlay without the need for dedicated repository software, you need to have `git` installed:

```console
emerge --ask --noreplace --verbose dev-vcs/git
````

Then you can simply download the guru repository configuration file, [guru.conf](metadata/guru.conf):

```console
wget https://gitweb.gentoo.org/repo/proj/guru.git/tree/metadata/guru.conf \
        -O /etc/portage/repos.conf/guru
```

### Manual Uninstall

To disable and remove the overlay, run:

```console
rm /etc/portage/repos.conf/guru
rm /var/db/repos/guru -rf
```

### Layman Install <a name="install-layman"></a>

You can also install the overlay via the [layman](https://wiki.gentoo.org/wiki/Layman) overlay manager.

```console
emerge --ask --noreplace --verbose app-portage/layman
layman --add guru
```

### Layman Uninstall

To delete the overlay, run:

```console
layman --delete guru
```

## Useful Links <a name="links"></a>

- https://wiki.gentoo.org/wiki/Project:GURU
- https://wiki.gentoo.org/wiki/Project:GURU/Information_for_Contributors
- https://wiki.gentoo.org/wiki/Project:GURU/Information_for_Trusted_Contributors
- https://wiki.gentoo.org/wiki/Basic_guide_to_write_Gentoo_Ebuilds
- https://devmanual.gentoo.org/quickstart
- https://devmanual.gentoo.org/ebuild-writing
- https://devmanual.gentoo.org/ebuild-writing/variables
- https://devmanual.gentoo.org/function-reference
- https://devmanual.gentoo.org/function-reference/install-functions
- https://dev.gentoo.org/~mgorny/python-guide/eclass.html
- [GURU outdated packages](https://repology.org/projects/?inrepo=gentoo_ovl_guru&outdated=on)
- [GURU Bugs](https://bugs.gentoo.org/buglist.cgi?f1=product&f2=component&list_id=7042152&o1=equals&query_format=advanced&resolution=---&v1=GURU&v2=Package%20issues)

## Email Addresses <a name="email"></a>

- guru@gentoo.org (Reach everyone involved in GURU)
- guru-committers@gentoo.org (Reach all contributors)
- guru-trusted@gentoo.org (Reach the [trusted contributors](https://wiki.gentoo.org/wiki/Project:GURU/Information_for_Trusted_Contributors))
- guru-devs@gentoo.org (Reach the Gentoo developers involved in GURU)
