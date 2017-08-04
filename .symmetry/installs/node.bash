#!/usr/bin/env bash
case $(__symmetry_platform) in
		macos|darwin)
			brew install node;
		;;
		microsoft|pi|ubuntu|debian)
			curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
			sudo apt install nodejs;

			sudo npm install npm -g -u;
			sudo npm install -g grunt jasmine codecov;
		;;
		*)
			echo "Unknown platform: $(__symmetry_platform)";
			exit 1;
		;;
	esac
fi
