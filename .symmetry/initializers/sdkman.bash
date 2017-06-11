#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash;

__symmetry_info "${BASH_SOURCE}";

if command -v sdk > /dev/null; then
	source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
