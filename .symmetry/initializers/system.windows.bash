#!/usr/bin/env bash

if [ -d "/mnt/e/Development" ]; then
	if [ ! -L "$HOME/Development" ]; then
		ln -s "/mnt/e/Development" "$HOME/Development"
	fi
fi
mkdir -p "/home/${USER}/Development"

if [ -d "/mnt/d/Users/${USER}/Desktop" ]; then
	if [ ! -L "$HOME/Desktop" ]; then
		ln -s "/mnt/d/Users/${USER}/Desktop" "$HOME/Desktop";
	fi
fi

if [ -d "/mnt/d/Users/${USER}/Dropbox" ]; then
	if [ ! -L "$HOME/Dropbox" ]; then
		ln -s "/mnt/d/Users/${USER}/Dropbox" "$HOME/Dropbox";
	fi
fi
if [ -d "/mnt/d/Users/${USER}/Box Sync" ]; then
	if [ ! -L "$HOME/Box Sync" ]; then
		ln -s "/mnt/d/Users/${USER}/Box Sync" "$HOME/Box Sync";
	fi
fi
if [ -d "/mnt/d/Users/${USER}/OneDrive" ]; then
	if [ ! -L "$HOME/OneDrive" ]; then
		ln -s "/mnt/d/Users/${USER}/OneDrive" "$HOME/OneDrive";
	fi
fi
if [ -d "/mnt/d/Users/${USER}/Google Drive" ]; then
	if [ ! -L "$HOME/Google Drive" ]; then
		ln -s "/mnt/d/Users/${USER}/Google Drive" "$HOME/Google Drive";
	fi
fi

if [ -d "/mnt/c/Users/${USER}/.ssh" ]; then
	if [ ! -L "$HOME/.ssh" ]; then
		if [ -d "$HOME/.ssh" ]; then
			mv "$HOME/.ssh" "$HOME/.ssh.old/";
		fi
		ln -s "/mnt/c/Users/${USER}/.ssh" "$HOME/.ssh";
		chmod 0600 "$HOME/.ssh/id_rsa";
		chmod 0600 "$HOME/.ssh/id_rsa.pub";
	fi
fi

mkdir -p "$HOME/.ssh";


if [ -d "/mnt/c/Users/${USER}/.aws" ]; then
	if [ ! -L "$HOME/.aws" ]; then
		ln -s "/mnt/c/Users/${USER}/.aws" "$HOME/.aws";
	fi
fi

if [ -d "/mnt/c/Users/${USER}/.azure" ]; then
	if [ ! -L "$HOME/.azure" ]; then
		ln -s "/mnt/c/Users/${USER}/.azure" "$HOME/.azure";
	fi
fi
