#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";
source_branch="develop"

# git pull origin $source_branch;

function __symmetry_bootstrap() {
	shopt -s dotglob;
	shopt -s extglob;

	rsync --exclude ".git/" \
		--exclude "bootstrap.sh" \
		--exclude "install.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . $HOME;

	shopt -u dotglob;
	shopt -u extglob;

	source $PWD/.symmetry/functions/._symmetry.bash;

	__load_config_files initializers default;

	source "$HOME/.bash_profile";

	echo -e "\n\n\n=========================Symmetry=========================\n";
	echo -e "\tYou should run 'symmetry install'";
	echo -e "\n==========================================================\n\n\n";
}


if [ "$1" == "--force" -o "$1" == "-f" ]; then
	__symmetry_bootstrap;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (Y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
