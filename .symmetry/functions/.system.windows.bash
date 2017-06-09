#!/usr/bin/env bash

if dotfiles_platform != "windows" > /dev/null 2>&1; then
	return
fi

# translate to linux path from windows path
function windir() {
	echo "$*" | sed -e 's|^\([a-z]\):\(.*\)|/mnt/\L\1\E\2|' -e 's|\\|/|g'
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
	CMD_DIR=$(wsldir "/mnt/c/Users/$USER/AppData/Local/lxss$HOME/.symmetry/functions\.env.ps1")
	echo $(powershell.exe -Command "Import-Module -Name $CMD_DIR; $CMD_VERB-EnvironmentVariables") | sed -e 's|\r|\n|g' -e 's|^[\s\t]*||g';
}
unset IS_WSL
