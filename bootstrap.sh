#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";
source_branch="develop"

# git pull origin $source_branch;

function doIt() {
	shopt -s dotglob;
	shopt -s extglob;

	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . $HOME;

	source $PWD/.symmetry/initializers/system.bash;

	shopt -u dotglob;
	shopt -u extglob;
	source "$HOME/.bash_profile";

	echo -e "\n\n\n=========================Symmetry=========================\n";
	echo -e "\tYou should run 'symmetry install'";
	echo -e "\n==========================================================\n\n\n";
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
