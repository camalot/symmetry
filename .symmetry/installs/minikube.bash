#!/usr/bin/env bash

case $(__symmetry_platform) in
	macos|darwin)
		brew cask install minikube;
	;;
	ubuntu|debian)

		if ! command -v vboxmanage 2>&1 /dev/null; then
			(>&2 echo "VirtualBox should be installed before minikube");
			exit 1;
		fi
		curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/;

		curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl;
		chmod +x kubectl;
		sudo mv kubectl /usr/local/bin/;

		source $HOME/.symmetry/functions/system.debian.bash;

		if command -v mkstart; then
			mkstart;
		else
			(>&2 echo "unable to find required mkstart command.");
			exit 1;
		fi
	;;
	*)
		(>&2 echo "Unsupported platform: $(__symmetry_platform)");
		exit 1;
	;;
esac
