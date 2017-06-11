#!/usr/bin/env bash

# https://github.com/nvbn/thefuck
if command -v thefuck > /dev/null ; then
	alias fuck='eval $(thefuck $(fc -ln -1)); history -r'
	alias please='fuck'
	alias oops='fuck'
fi
