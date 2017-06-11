#!/usr/bin/env bash

_update_ps1() {
	PS1="$($HOME/.symmetry/propmps/powerline/powerline-shell.py $? 2> /dev/null)";
}

if [ "$TERM" != "linux" ]; then
	PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND";
fi

unset _update_ps1;
