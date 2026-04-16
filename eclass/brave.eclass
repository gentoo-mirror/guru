# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: brave.eclass
# @MAINTAINER:
# Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
# @AUTHOR:
# Florian Albrechtskirchinger <falbrechtskirchinger@gmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB: Shared functions for brave-browser

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

# @FUNCTION: brave_remove_language_dirs
# @USAGE:
# @DESCRIPTION:
# Removes language directories containing messages.json files from the current
# directory for languages that the user has not selected via the L10N variable.
# Also performs QA checks to ensure CHROMIUM_LANGS has been set correctly.
brave_remove_language_dirs() {
	local lang dir

	# Look for missing language directories.
	for lang in ${CHROMIUM_LANGS}; do
		dir=${lang//-/_}
		if [[ ! -d ${dir} ]]; then
			eqawarn "QA Notice: L10N warning: no locale folder for ${lang} (${dir}/ not found)"
		elif [[ ! -f ${dir}/messages.json ]]; then
			eqawarn "QA Notice: L10N warning: no messages.json for ${lang}"
		fi
	done

	# Look for extra locale directories.
	# Remove locale directories the user does not want.
	for dir in */; do
		dir=${dir%/}
		lang=${dir//_/-}

		if [[ ${lang} == en-US ]]; then
			continue
		fi

		if ! has ${lang} ${CHROMIUM_LANGS}; then
			eqawarn "QA Notice: L10N warning: no ${lang} in LANGS"
			continue
		fi

		if ! use l10n_${lang}; then
			rm "${dir}/messages.json" || die
			rmdir "${dir}/" || die
		fi
	done
}
