#!/usr/bin/env bash
set -e;
NODEJS_VERSION="9";
case $(__symmetry_platform) in
	macos|darwin)
		brew install node;
	;;
	windows|pi|ubuntu|debian)
		curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -;
		sudo apt update;
		sudo apt install nodejs -yq;

		sudo npm install npm -g -u;
		sudo npm install -g grunt codecov;

		sudo chown -R $USER:$(id -gn $USER) $HOME/.config;
	;;
	*)
		echo "Unknown platform: $(__symmetry_platform)";
		exit 1;
	;;
esac
unset NODEJS_VERSION;
