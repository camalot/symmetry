#!/usr/bin/env bash

_ruby_install() {
	if [ "$#" -eq 0 ] && [[ "$1" =~ '^\d{1,}\.\d{1,}\.\d{1,}$']]; then
		RUBY_VER=$1;
	else
		RUBY_VER="2.4.1";
	fi

	case $(__symmetry_platform) in
		macos|darwin)
			brew install ruby-build;
			brew install rbenv;

		;;
		microsoft|pi|ubuntu|debian)
			sudo apt install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev nodejs -y;

			git clone https://github.com/rbenv/rbenv.git $HOME/.rbenv;
			git clone https://github.com/rbenv/ruby-build.git $HOME/.rbenv/plugins/ruby-build;
		;;
		*)
			echo "Unknown platform: $(__symmetry_platform)";
			exit 1;
		;;
	esac

	rbenv init
	rbenv install $RUBY_VER;
	rbenv global $RUBY_VER;
	ruby -v;

	source $PWD/.symmetry/installs/gems.bash;
}

_ruby_install $@;

unset _ruby_install;
