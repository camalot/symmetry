#!/usr/bin/env bash


source $HOME/.symmetry/functions/._symmetry.bash;
__symmetry_info "$BASH_SOURCE";

# do nothing if this system is not windows
if $(__symmetry_platform) != "windows" > /dev/null 2>&1; then
	__symetry_notice "Platform not supported";
	return;
fi

source "$HOME/.symmetry/functions/system.windows.bash";

if command -v winenv > /dev/null 2>&1; then
	export POWERSHELL=~/bin/powershell;
	export LXSS_ROOT=$WIN_LOCALAPPDATA/lxss;
	if [[ ! -d $LXSS_ROOT ]]; then
		# this should loop all the paths found, and check rootfs for existance.
		echo "check for non-legacy version of ubuntu on windows";
		temp_paths=$(echo $WIN_LOCALAPPDATA/Packages/CanonicalGroupLimited.UbuntuonWindows_*);
		first_ubuntu_path=$(echo "${temp_paths%% *}");
		export LXSS_ROOT="$first_ubuntu_path/LocalState/rootfs;
	fi
	eval $(winenv);
fi
