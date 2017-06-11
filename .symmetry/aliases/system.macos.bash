#!/usr/bin/env bash

if $(__symmetry_platform) != "macos" > /dev/null 2>&1; then
	return
fi

# PlistBuddy alias, because sometimes `defaults` just doesnt cut it
alias plistbuddy="/usr/libexec/PlistBuddy";


# Ring the terminal bell, and put a badge on Terminal.apps Dock icon
# (useful when executing time-consuming commands)
alias badge="tput bel";

# Recursively delete `.DS_Store` files
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete";

alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U';
