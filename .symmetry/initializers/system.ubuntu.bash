#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash

__symmetry_info "$BASH_SOURCE";
if $(__symmetry_platform) != "ubuntu" > /dev/null 2>&1; then
	__symetry_notice "Platform not supported";
	return;
fi
