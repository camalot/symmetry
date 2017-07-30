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
		--exclude "readme.md" \
		--exclude "*.log" \
		--exclude "license.md" \
		-avh --no-perms . $HOME;

	shopt -u dotglob;
	shopt -u extglob;

	source $PWD/.symmetry/functions/._symmetry.bash;
	__symmetry_logo;
	__symmetry_config_load;
	__load_config_files initializers default;

	chmod 0755 -R "$HOME/.symmetry";

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
		__symmetry_bootstrap;
	fi;
fi;
unset __symmetry_bootstrap;
