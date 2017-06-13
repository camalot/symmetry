#!/usr/bin/env bash
if command -v uname > /dev/null; then
	case $(uname -s | awk '{print tolower($0)}') in
		darwin)
			brew install node;
		;;
		microsoft|pi|ubuntu|debian)
			curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
			sudo apt install nodejs;

			sudo npm install npm -g -u;
			sudo npm install -g grunt jasmine codecov;
		;;
	esac
fi
