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

		curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/;


		minikube start;
		## wait for minikube to start
		trap 'break' 90;
		printf "waiting for minikube vm to start up.";
		mkubevm=0;
		while true; do
			mkubevm=$((vboxmanage showvminfo "minikube" 2>/dev/null) | grep -c "running (since");
			if [ mkubevm -eq 1 ]; then
				break;
			fi
			sleep 5;
			printf ".";
		done;
		if [ mkubevm -eq 1 ]; then
			echo -e "\nbinding port 9090 to minikube";
			socat tcp-listen:9090,fork tcp:$(minikube ip):30000 &
		else
			(>&2 echo -e "\nUnable to find minikube vm in allotted time.");
			exit 1;
		fi
	;;
	*)
		(>&2 echo "Unsupported platform: $(__symmetry_platform)");
		exit 1;
	;;
esac
