#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";
who="$(whoami)"
group="$(id -gn $who)"
source_branch="develop"

git pull origin $source_branch;

function doIt() {
	shopt -s dotglob
	# sudo chown $who:$who ~/bin
	# sudo chown -R $who:$group $HOME/.config

	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude ".authorized_keys" \
		--exclude ".installs/" \
		-avh --no-perms . ~;

	local IS_WSL=$( uname -r | grep -o -P 'Microsoft$' -q && echo 1 || echo 0 )

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

	if [ -d "$HOME/.ssh" ]; then
		if [ ! -f "$HOME/.ssh/authorized_keys" ]; then
			cp ".authorized_keys" "$HOME/.ssh/authorized_keys"
		else
			while IFS='' read -r line || [[ -n "$line" ]]; do
				if grep -Fxq "$line" "$HOME/.ssh/authorized_keys"; then
					echo "skipping '${line:8:16}' because it already exists"
				else
					echo "$line" >> "$HOME/.ssh/authorized_keys"
				fi
			done < ".authorized_keys"
		fi
	fi


	if [ -d "$HOME/Dropbox/keys/.ssh" ]; then
		if [ ! -L "$HOME/.keys" ]; then
			ln -s $HOME/Dropbox/keys/.ssh $HOME/.keys
		fi
	fi

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

	chown $who:$who ~/bin/jenkins
	chmod +x ~/bin/jenkins

	unset IS_WSL
	source "$HOME/.bash_profile"
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (Y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
