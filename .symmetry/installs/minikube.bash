#!/usr/bin/env bash

case $(__symmetry_platform) in
	macos|darwin)
		brew cask install minikube;
	;;
	ubuntu|debian)
		curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/;
	;;
	*)
		echo "Unsupported platform: $(__symmetry_platform)";
		exit 1;
	;;
esac
