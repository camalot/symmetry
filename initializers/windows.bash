#!/usr/bin/env bash


	if [ -d "/mnt/e/Development" ]; then
		if [ ! -L "$HOME/Development" ]; then
			ln -s "/mnt/e/Development" "$HOME/Development"
		fi
	fi
	mkdir -p "/home/${who}/Development"

	if [ -d "/mnt/d/Users/${who}/Desktop" ]; then
		if [ ! -L "$HOME/Desktop" ]; then
			ln -s "/mnt/d/Users/${who}/Desktop" "$HOME/Desktop"
		fi
	fi

	if [ -d "/mnt/d/Users/${who}/Dropbox" ]; then
		if [ ! -L "$HOME/Dropbox" ]; then
			ln -s "/mnt/d/Users/${who}/Dropbox" "$HOME/Dropbox"
		fi
	fi
	if [ -d "/mnt/d/Users/${who}/Box Sync" ]; then
		if [ ! -L "$HOME/Box Sync" ]; then
			ln -s "/mnt/d/Users/${who}/Box Sync" "$HOME/Box Sync"
		fi
	fi
	if [ -d "/mnt/d/Users/${who}/OneDrive" ]; then
		if [ ! -L "$HOME/OneDrive" ]; then
			ln -s "/mnt/d/Users/${who}/OneDrive" "$HOME/OneDrive"
		fi
	fi
	if [ -d "/mnt/d/Users/${who}/Google Drive" ]; then
		if [ ! -L "$HOME/Google Drive" ]; then
			ln -s "/mnt/d/Users/${who}/Google Drive" "$HOME/Google Drive"
		fi
	fi

	if [ -d "/mnt/c/Users/${who}/.ssh" ]; then
		if [ ! -L "$HOME/.ssh" ]; then
			if [ -d "$HOME/.ssh" ]; then
				mv "$HOME/.ssh" "$HOME/.ssh.old/"
			fi
			ln -s "/mnt/c/Users/${who}/.ssh" "$HOME/.ssh"
			chmod 0600 "$HOME/.ssh/id_rsa"
			chmod 0600 "$HOME/.ssh/id_rsa.pub"
		fi
	fi

	mkdir -p "$HOME/.ssh"


	if [ -d "/mnt/c/Users/${who}/.aws" ]; then
		if [ ! -L "$HOME/.aws" ]; then
			ln -s "/mnt/c/Users/${who}/.aws" "$HOME/.aws"
		fi
	fi

	if [ -d "/mnt/c/Users/${who}/.azure" ]; then
		if [ ! -L "$HOME/.azure" ]; then
			ln -s "/mnt/c/Users/${who}/.azure" "$HOME/.azure"
		fi
	fi
