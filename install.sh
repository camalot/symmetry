#!/usr/bin/env bash

source $PWD/.functions/._symmetry.bash || exit 2;

SYMMETRY_PLATFORM=$(dotfiles_platform);

# shopt -s dotglob;
# shopt -s extglob;

# if [ -d "$PWD/installs" ]; then
# 	# all non-system specific files and 'this' file
# 	FILES="$PWD/installs/@(!(.system.*@(windows|macos|pi|linux)|._*)).bash";
# 	for config_file in $FILES; do
# 		if [ -f "${config_file}" ]; then
# 			source $config_file;
# 		fi
# 	done
# fi
if [ -f "$PWD/installs/system.${SYMMETRY_PLATFORM}.bash" ]; then
	# source the specific system functions file
	echo "$PWD/installs/system.${SYMMETRY_PLATFORM}.bash";
	source $PWD/installs/system.${SYMMETRY_PLATFORM}.bash;
fi

unset SYMMETRY_PLATFORM;
