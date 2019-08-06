#!/usr/bin/env bash
set -e;

GO_VERSION="1.12.7";
curl -O https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz

tar xvf go${GO_VERSION}.linux-amd64.tar.gz

sudo chown -R root:root ./go;
sudo mv go /usr/local;

rm "go${GO_VERSION}.linux-amd64.tar.gz";

mkdir -p $HOME/work;
