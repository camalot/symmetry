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
	eval $(winenv);
	export POWERSHELL=~/bin/powershell;
	#export LXSS_ROOT=$WIN_LOCALAPPDATA/lxsszz;
	#if [[ ! -d $LXSS_ROOT ]]; then
		# this should loop all the paths found, and check rootfs for existance.
		export LXSS_ROOT="$(winwslroot)";
		echo "LXSS_ROOT: $LXSS_ROOT";
	#fi
fi

