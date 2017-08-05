#!/usr/bin/env bash

case $(__symmetry_platform) in
	macos|darwin)

	;;
	microsoft|pi|ubuntu|debian)
		sudo apt install nginx -y;
		sudo update-rc.d nginx defaults;
		sudo /etc/init.d/nginx start;
	;;
	*)
		echo "Unknown platform: $(__symmetry_platform)";
		exit 1;
	;;
esac
