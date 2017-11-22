#!/usr/bin/env bash
source $HOME/.symmetry/functions/._symmetry.bash || exit 2;

source $HOME/.symmetry/installs/screenfetch.bash;
source $HOME/.symmetry/installs/tldr.bash;
source $HOME/.symmetry/installs/cheat.bash;


# the installs should ONLY load the system specific script
system_platform=$(__symmetry_platform);
if [ -f "$HOME/.symmetry/installs/system.${system_platform}.bash" ]; then
	source $HOME/.symmetry/installs/system.${system_platform}.bash;
else
	echo "Unable to find install file for ${system_platform}";
	exit 2;
fi


