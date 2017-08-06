#!/usr/bin/env bash
case $(__symmetry_platform) in
	ubuntu|debian)
		source $HOME/.symmetry/functions/system.debian.bash;

		if ! command -v docker > /dev/null; then
			(>&2 echo "Docker should be installed before kubernetes");
			exit 1;
		fi

		curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl;
		chmod +x kubectl;
		sudo mv kubectl /usr/local/bin/;

		sudo apt-get update;

		sudo apt install apt-transport-https -y;
		curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -;
		echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list > /dev/null;

		sudo apt update;
		sudo apt install kubelet kubeadm -y;
		echo "initializing kubernetes...";
		ktoken_data=$(sudo kubeadm init --pod-network-cidr=192.168.0.0/16);
		# kubeadm join --token cc7782.faf6b5e82250d4df 192.168.2.12:6443
		ktoken=$(echo $ktoken_data | grep 'kubeadm join --token' | awk '{ print $4 }');
		kmaster=$(echo $ktoken_data | grep 'kubeadm join --token' | awk '{ print $5 }');

		mkdir -p $HOME/.kube;
	  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config;
	  sudo chown $(id -u):$(id -g) $HOME/.kube/config;

		kubectl apply -f "http://docs.projectcalico.org/v2.3/getting-started/kubernetes/installation/hosted/kubeadm/1.6/calico.yaml";

		sudo kubectl taint nodes --all node-role.kubernetes.io/master-;

		echo -e "To join nodes to this cluster run:\n\tkubeadm join --token $ktoken $kmaster";
	;;
	*)
		(>&2 echo "Unsupported platform: $(__symmetry_platform)");
		exit 1;
	;;
esac
