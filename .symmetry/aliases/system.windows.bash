#!/usr/bin/env bash

# shellcheck disable=SC2128
__symmetry_info "$BASH_SOURCE";

if $(__symmetry_platform) != "windows" > /dev/null 2>&1; then
	__symetry_notice "Platform not supported";
	return;
fi

alias winpath='echo -e ${WIN_PATH//:/\\n}';

# Get Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update='sudo apt update; apt upgrade; apt clean; apt autoremove; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U';


alias ipconfig="ipconfig.exe"
