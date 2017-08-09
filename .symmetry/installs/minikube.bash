#!/usr/bin/env bash
set -e;
function _install_minikube() {
	case $(__symmetry_platform) in
		macos|darwin)
			brew update;
			brew cask install minikube kops;

			curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl;
			chmod +x kubectl;
			sudo mv kubectl /usr/local/bin;
		;;
		ubuntu|debian)

			if ! command -v vboxmanage 2>&1 /dev/null; then
				(>&2 echo "VirtualBox should be installed before minikube");
				exit 1;
			fi

			echo "downloading latest minikube";
			curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64l
			chmod +x minikube;
			sudo mv minikube /usr/local/bin/;
			echo "getting latest stable version of kubctl...";
			local kversion=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt);
			echo "downloading kubctl $kversion";
			curl -LO https://storage.googleapis.com/kubernetes-release/release/${kversion}/bin/linux/amd64/kubectl;
			chmod +x kubectl;
			sudo mv kubectl /usr/local/bin/;

			echo "getting latest kops version...";
			local kops_version=$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | jq -r '.name');
			echo "installing kops $kops_version";
			curl -sLO https://github.com/kubernetes/kops/releases/download/${kops_version}/kops-linux-amd64;
			chmod +x kops-linux-amd64;
			sudo mv kops-linux-amd64 /usr/local/bin/kops;

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

	echo "Installation of minikube completed.";
}

_install_minikube $@;
