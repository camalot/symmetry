#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash || exit 2;

# the installs should ONLY load the system specific script
system_platform=$(__symmetry_platform);

if [ -f "$HOME/.symmetry/installs/system.${system_platform}.bash" ]; then
	source $HOME/.symmetry/installs/system.${system_platform}.bash;
fi
