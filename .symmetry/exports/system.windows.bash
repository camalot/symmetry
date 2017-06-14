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
	eval $(winenv);
fi
