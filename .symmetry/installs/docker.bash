#!/usr/bin/env bash
case $(__symmetry_platform) in
	macos|darwin)
		brew install docker;
	;;
	ubuntu|debian|windows)
		DOCKER_CHANNEL=edge
		DOCKER_COMPOSE_VERSION=1.18.0

		sudo apt-get update;
		sudo apt-get install -yq \
		    apt-transport-https \
		    ca-certificates \
		    curl \
		    software-properties-common;

		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
		sudo apt-key fingerprint 0EBFCD88;
		sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   ${DOCKER_CHANNEL}";
		sudo apt update;
		apt-cache policy docker-ce;
		sudo apt install -yq docker-ce;
		sudo usermod -aG docker ${USER};

		sudo curl -sL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` \
		-o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose;
	;;
	*)
		echo "Unknown platform: $(__symmetry_platform)";
		exit 1;
	;;
esac
