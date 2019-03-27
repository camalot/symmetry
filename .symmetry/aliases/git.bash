#!/usr/bin/env bash

if command -v git >& /dev/null; then
	alias g="git";
	alias got="git";
fi

function gi() { curl -L -s https://www.gitignore.io/api/\$@ ;}
