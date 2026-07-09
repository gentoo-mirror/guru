# Copyright 2026 Gentoo Authors
# Copyright 2026 Lamco Development LLC
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )
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

src_prepare() {
	default

	# Drop any Python bytecode the artifact carried; it is regenerated at
	# runtime and would otherwise pull host paths into the package.
	find . -type d -name __pycache__ -exec rm -rf {} + || die
	find . -type f -name '*.pyc' -delete || die

	# Normalise permissions: directories 0755, files 0644, keeping the
	# executable bit where the tarball already set it (lamboot-install,
	# lamboot-inspect, sign-lamboot.sh + its sign-lock/sign-unlock helpers,
	# the .efi loaders). Mirrors the deb's `chmod -R u=rwX,go=rX`. The
	# wholesale cp in src_install then preserves these modes.
	chmod -R u=rwX,go=rX . || die "failed to normalise source perms"

	# Pin the Python diagnostic scripts' shebangs to the selected interpreter
	# (python-single-r1). lamboot-host-sampler and the rest are bash, left as-is.
	python_fix_shebang lamboot-inspect lamboot-monitor.py
}

src_install() {
	# Stage the whole distribution under /usr/share/lamboot — lamboot-install's
	# SRC_DIR (it searches /usr/share/lamboot, /usr/local/share/lamboot, then
	# /opt/lamboot, and copies the .efi to the operator's ESP from there). Copy
	# the tree wholesale to preserve the +x bits on scripts, rather than doins
	# (which forces 0644 and would break lamboot-install's exec of its siblings).
	local share="${ED}/usr/share/lamboot"
	dodir /usr/share/lamboot
	cp -a "${S}"/. "${share}"/ || die "failed to stage distribution"

	# Prune the copies installed to their own paths below (man, completions,
	# the README/CHANGELOG/SECURITY docs) or not installed at all (packaging,
	# docs, the license texts, the manifest); lamboot-install reads none of
	# them from SRC_DIR.
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

	# Documentation. The MIT and Apache-2.0 license texts are not installed:
	# both are in Gentoo's license tree and tracked via LICENSE above.
	dodoc README.md CHANGELOG.md SECURITY.md

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
