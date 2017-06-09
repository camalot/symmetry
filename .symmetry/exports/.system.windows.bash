#!/usr/bin/env bash

# do nothing if this system is not windows
if $(dotfiles_platform) != "windows" > /dev/null 2>&1; then
	return;
fi

if command -v winenv > /dev/null 2>&1; then
	export POWERSHELL=~/bin/powershell;
	export LXSS_ROOT=$WIN_LOCALAPPDATA/lxss;
fi

eval $(winenv);
