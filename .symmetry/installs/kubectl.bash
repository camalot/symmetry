#!/usr/bin/env bash


local kubernetes_version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt);
echo "downloading kubectl version $kubernetes_version";
curl -sLO https://storage.googleapis.com/kubernetes-release/release/$kubernetes_version/bin/linux/amd64/kubectl;
chmod +x kubectl;
sudo mv kubectl /usr/local/bin/;
