#!/usr/bin/env bash

function _install_kubectl() {
	local install_platform="linux";
	case $(__symmetry_platform) in
		ubuntu|debian|windows)
			install_platform="linux";
		;;
		darwin|macos)
			install_platform="darwin";
		;;
	esac
	local kubernetes_version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt);
	echo "downloading kubectl version $kubernetes_version";
	curl -sLO https://storage.googleapis.com/kubernetes-release/release/$kubernetes_version/bin/${install_platform}/amd64/kubectl;
	chmod +x kubectl;
	sudo mv kubectl /usr/local/bin/;
}

_install_kubectl $@;
