#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash;
__symmetry_info "$BASH_SOURCE";

if $(__symmetry_platform) != "windows" > /dev/null 2>&1; then
	__symetry_notice "Platform not supported";
	return;
fi

# translate to linux path from windows path
function windir() {
	echo "$*" | sed -e 's|^\([A-Za-z]\):\(.*\)|/mnt/\L\1\E\2|' -e 's|\\|/|g'
}

# translate the path back to windows path
function wsldir() {
	echo "$*" | sed -e 's|^/mnt/\([a-z]\)/\(.*\)|\U\1\:\\\E\2|' -e 's|/|\\|g'
}

# gets the lxss path from windows
function lxssdir() {
	if [ $# -eq 0 ]; then
		if echo "$PWD" | grep "^/mnt/[a-zA-Z]/" > /dev/null 2>&1; then
			echo "$PWD";
		else
			echo "$LXSS_ROOT$PWD";
		fi
	else
		# when the path is like `../foo/bar.ps1` it should return the FQP (fully qualified path) transformed by lxssdir
		if echo "$1" | grep "^\.\{1,2\}/" > /dev/null 2>&1; then
			lxssdir "$PWD/$1"
		else
			echo "$LXSS_ROOT$1";
		fi
	fi
}

function printwinenv() {
	_winenv --get
}

# this will load the output exports of the windows envrionment variables
function winenv() {
	_winenv --import
}

function _winenv() {
	if [ $# -eq 0 ]; then
		CMD_VERB="Get"
	else
		while test $# -gt 0; do
		  case "$1" in
				-g|--get)
				CMD_VERB="Get"
				shift
				;;
				-i|--import)
				CMD_VERB="Import"
				shift
				;;
				*)
				CMD_VERB="Get"
				break
				;;
			esac
		done
	fi

	temp_paths=$(echo /mnt/c/Users/rconr/AppData/Local/Packages/CanonicalGroupLimited.UbuntuonWindows_*);
	echo "temp_paths: $temp_paths";
	first_ubuntu_path=$(echo "${temp_paths%% *}");
	CMD_DIR=$(wsldir "$first_ubuntu_path/LocalState/rootfs$HOME/.symmetry/functions\.env.ps1")
	echo $(powershell.exe -Command "Import-Module -Name $CMD_DIR; $CMD_VERB-EnvironmentVariables") | sed -e 's|\r|\n|g' -e 's|^[\s\t]*||g';
}
