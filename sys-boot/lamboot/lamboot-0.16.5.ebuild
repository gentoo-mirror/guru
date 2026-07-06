# Copyright 2026 Lamco Development LLC
# Distributed under the terms of the MIT or Apache-2.0 license

EAPI=8

PYTHON_COMPAT=( python3_{11..14} )
inherit python-single-r1 shell-completion

DESCRIPTION="Memory-safe UEFI bootloader for Linux, written in Rust"
HOMEPAGE="https://lamco.ai/products/lamboot/ https://github.com/lamco-admin/lamboot"

# Prebuilt binary ebuild: this repackages the published Secure Boot-signed
# -bin release artifact (the same tarball AUR lamboot-bin and apt.lamco.ai
# consume). It does not build from source, so no nightly Rust toolchain and
# no signing keys are needed at merge time. A build-from-source ebuild is a
# separate track, gated on whether LamBoot builds on stable rustc for the
# *-unknown-uefi targets without -Z build-std (see ../../../PACKAGING.md).
SRC_URI="https://github.com/lamco-admin/lamboot/releases/download/v${PV}/lamboot-${PV}-x86_64.tar.gz"
S="${WORKDIR}/lamboot-${PV}"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# The shipped .efi is a Secure Boot-signed PE binary. Stripping it (or running
# any ELF post-processing over it) rewrites the file and invalidates the
# signature, so the firmware rejects it under Secure Boot. Forbid strip.
RESTRICT="strip"

# efibootmgr: lamboot-install registers the UEFI boot entry through it.
# python: lamboot-inspect and lamboot-monitor.py are Python 3 programs; the
# python-single-r1 eclass declares the dependency and pins the script shebangs.
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
RDEPEND="
	sys-boot/efibootmgr
	${PYTHON_DEPS}
"

# The signed PE binaries are not ELF; tell the QA scanners not to treat them
# as broken ELF objects or to expect them to be stripped.
QA_PREBUILT="usr/share/lamboot/EFI/LamBoot/*.efi
	usr/share/lamboot/EFI/LamBoot/modules/*.efi
	usr/share/lamboot/EFI/LamBoot/drivers/*/*.efi"

src_install() {
	# Stage the whole distribution under /usr/share/lamboot. This is
	# lamboot-install's SRC_DIR: it searches /usr/share/lamboot,
	# /usr/local/share/lamboot, then /opt/lamboot, and copies the .efi to the
	# operator's ESP from there. We copy the tree wholesale (preserving the
	# tarball's +x bits on scripts) rather than using doins, which would force
	# 0644 and break lamboot-install's exec of its sibling helpers.
	#
	# Exclude build/packaging metadata, the man page, completions, docs, the
	# top-level README/CHANGELOG/SECURITY/LICENSE files, the manifest, and
	# Python bytecode: those are installed to their own paths below (or not at
	# all), and lamboot-install does not read them from SRC_DIR.
	local share="${ED}/usr/share/lamboot"
	dodir /usr/share/lamboot
	cp -a "${S}"/. "${share}"/ || die "failed to stage distribution"
	rm -rf \
		"${share}"/packaging \
		"${share}"/man \
		"${share}"/completions \
		"${share}"/docs \
		"${share}"/README.md \
		"${share}"/CHANGELOG.md \
		"${share}"/SECURITY.md \
		"${share}"/LICENSE-MIT \
		"${share}"/LICENSE-APACHE \
		"${share}"/MANIFEST.sha256 \
		|| die "failed to prune staged tree"
	# Drop any Python bytecode the artifact carried; it is regenerated at
	# runtime and would otherwise pull host paths into the package.
	find "${share}" -type d -name __pycache__ -exec rm -rf {} + || die
	find "${share}" -type f -name '*.pyc' -delete || die

	# Normalise staged permissions: directories 0755, files 0644, but keep the
	# executable bit on the scripts/binaries that carried it (lamboot-install,
	# lamboot-inspect, sign-lamboot.sh and its sign-lock/sign-unlock helpers,
	# the .efi loaders, etc.). No group/other write. Mirror the deb's
	# `chmod -R u=rwX,go=rX`, which preserves +x where it was already set.
	chmod -R u=rwX,go=rX "${share}" || die "failed to normalise staged perms"

	# Pin the Python diagnostic scripts' shebangs to the selected interpreter
	# (python-single-r1). lamboot-host-sampler and the rest are bash, left as-is.
	python_fix_shebang \
		"${share}"/lamboot-inspect \
		"${share}"/lamboot-monitor.py

	# esp-deploy.sh at the canonical literal path. lamboot-install checks
	# /usr/lib/lamboot/esp-deploy.sh first, then the script-relative
	# ../lib/esp-deploy.sh. Use the literal /usr/lib (NOT $(get_libdir)):
	# on amd64 that resolves to /usr/lib64, where lamboot-install does not
	# look. It is a sourced shell library, so 0644 is correct.
	insinto /usr/lib/lamboot
	doins lib/esp-deploy.sh

	# Operator CLIs on PATH as relative symlinks into the staged tree, so each
	# script's realpath-based sibling lookups resolve: lamboot-inspect imports
	# the adjacent lamboot_inspect package, and sign-lamboot.sh execs the
	# adjacent sign-unlock/sign-lock. The staged systemd units hardcode
	# /usr/bin/lamboot-install, so these must land in /usr/bin, not /usr/sbin.
	dodir /usr/bin
	dosym ../share/lamboot/lamboot-install /usr/bin/lamboot-install
	dosym ../share/lamboot/lamboot-inspect /usr/bin/lamboot-inspect
	dosym ../share/lamboot/sign-lamboot.sh /usr/bin/lamboot-sign

	# Man page, shell completions (newbashcomp + dozshcomp from shell-completion).
	doman man/man1/lamboot-inspect.1
	newbashcomp completions/lamboot-inspect.bash lamboot-inspect
	dozshcomp completions/_lamboot-inspect

	# Documentation and dual license.
	dodoc README.md CHANGELOG.md SECURITY.md
	# The -bin tarball is thinned (PACKAGING.md §0): the full docs/ tree lives in
	# the public repo + website, not the artifact, so it is absent here. Install
	# it only if present, otherwise dodoc dies against the thinned tarball.
	if [[ -d docs ]]; then
		dodoc -r docs/.
	fi
	# Gentoo installs license texts under /usr/share/licenses/<pkg>.
	insinto /usr/share/licenses/${PN}
	doins LICENSE-MIT LICENSE-APACHE

	# Note what we deliberately do NOT install: the systemd units, the
	# kernel-install plugin, the kernel-event hooks, and lamboot-kernel-hook.
	# lamboot-install deploys all of those at runtime from /usr/share/lamboot.
	# The package never writes the ESP or /etc. (The AUR package's one
	# exception, the alpm kernel hook, is an Arch-only convention and has no
	# Gentoo equivalent here.)
}

pkg_postinst() {
	elog "LamBoot is staged under /usr/share/lamboot but is NOT yet installed to"
	elog "the EFI System Partition. To deploy the bootloader and register a UEFI"
	elog "boot entry, run:"
	elog ""
	elog "    sudo lamboot-install --signed"
	elog ""
	elog "Secure Boot today means MOK or sbctl enrollment; this package never"
	elog "enrolls a key for you. To trust the shipped signed bootloader under"
	elog "shim, enroll the LamBoot signing certificate:"
	elog ""
	elog "    sudo mokutil --import /usr/share/lamboot/lamboot-signing.der"
	elog "    (set a one-time password, reboot, complete enrollment in MokManager)"
	elog ""
	elog "Or, with sbctl, sign/enroll through your own Secure Boot key hierarchy."
	elog "Full guide: /usr/share/doc/${PF}/"
}
