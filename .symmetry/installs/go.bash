#!/usr/bin/env bash
set -e;

GO_VERSION="1.8.3";
curl -O https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz

tar xvf go${GO_VERSION}.linux-amd64.tar.gz

sudo chown -R root:root ./go;
sudo mv go /usr/local;

rm "go${GO_VERSION}.linux-amd64.tar.gz";

mkdir -p $HOME/work;
