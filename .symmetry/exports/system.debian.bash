#!/usr/bin/env bash
#shellcheck source=/dev/null
source $HOME/.symmetry/functions/._symmetry.bash;
#shellcheck disable=SC2128
__symmetry_info "$BASH_SOURCE";

if $(__symmetry_platform) != "ubuntu" > /dev/null 2>&1; then
	__symetry_notice "Platform not supported";
	return;
fi
