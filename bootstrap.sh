#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";
group="$(id -gn $USER)"
source_branch="develop"

# git pull origin $source_branch;

function doIt() {
	shopt -s dotglob;
	shopt -s extglob;
	# sudo chown $who:$who ~/bin
	# sudo chown -R $who:$group $HOME/.config

	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude ".authorized_keys" \
		--exclude "installs/" \
		--exclude "initializers/" \
		-avh --no-perms . ~;

	INIT_FILES="$PWD/initializers/!(@(windows|macos|pi|linux)).bash";
	for file in $INIT_FILES; do
		if [ -f "${file}" ]; then
			source $file;
		fi
	done

	shopt -u dotglob;
	shopt -u extglob;
	source "$HOME/.bash_profile";
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
