#!/usr/bin/env bash
case $(__symmetry_platform) in
	macos|darwin)

	;;
	ubuntu|debian)
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
		sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";
		sudo apt update;
		apt-cache policy docker-ce;
		sudo apt install -y docker-ce;
		sudo systemctl status docker;
		sudo usermod -aG docker ${USER};
	;;
	*)
		echo "Unknown platform: $(__symmetry_platform)";
		exit 1;
	;;
esac
