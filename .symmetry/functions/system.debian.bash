#!/usr/bin/env bash

function mkstart() {
	# if ! command -v minikube > /dev/null || ! command -v socat > /dev/null || ! command -v vboxmanage > /dev/null; then
	# 	(>&2 echo "Missing required tool to run mkstart");
	# 	exit 1;
	# fi
	minikube start;
	## wait for minikube vm to start
	printf "waiting for minikube vm to start up.";
	local mkubevm="0";
	local mcount_base="1";
	local mcount="0";
	local mcount_max=$(expr 90 / 5);
	while true; do
		mkubevm=$((vboxmanage showvminfo "minikube" 2>/dev/null) | grep -c "running (since");
		if [ $mkubevm -eq 1 ] || [ $mcount -ge $mcount_max ]; then
			break;
		fi
		sleep 5;
		printf ".";
		mcount=$(expr $mcount + $mcount_base);
	done;
	if [ $mkubevm -eq 1 ]; then
		local mkip=$(minikube ip);
		echo -e "\nbinding 0.0.0.0:9090 to minikube ${mkip}:30000";
		socat tcp-listen:9090,fork tcp:${mkip}:30000 > /dev/null &
	else
		(>&2 echo -e "\nUnable to find minikube vm in allotted time.");
		return;
	fi
}
