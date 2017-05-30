#!/usr/bin/env bash

if dotfiles_platform != "macos" > /dev/null 2>&1; then
	return
fi

echo "running macos exports"
