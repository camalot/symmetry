#!/usr/bin/env bash
case $(__symmetry_platform) in
	ubuntu|debian)
		source $HOME/.symmetry/functions/system.debian.bash;

		if ! command -v docker 2>&1 /dev/null; then
			(>&2 echo "Docker should be installed before kubernetes");
			exit 1;
		fi

		curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/;

		sudo apt-get update;

		sudo apt install apt-transport-https -y;
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;
		sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
		sudo apt update;
		sudo apt install kubelet kubeadm -y;


	;;
	*)
		(>&2 echo "Unsupported platform: $(__symmetry_platform)");
		exit 1;
	;;
esac
