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
		--exclude "installs/" \
		--exclude "initializers/" \
		-avh --no-perms . ~;

	local IS_WSL=$( uname -r | grep -o -P 'Microsoft$' -q && echo 1 || echo 0 )


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
