#!/usr/bin/env bash

function mkstart() {
	if ! ( command -v minikube 2>&1 /dev/null || command -v socat 2>&1 /dev/null || command -v vboxmanage 2>&1 /dev/null ); then
		(>&2 echo "Missing required tool to run mkstart");
		exit 1;
	fi
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
}
