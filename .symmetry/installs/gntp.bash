#!/usr/bin/env bash


# https://github.com/mattn/gntp-send/releases/download/0.3.4/gntp-send-0.3.4.tar.gz
apt-add-repository ppa:mattn/gntp-send -y;
echo -n "deb http://ppa.launchpad.net/mattn/gntp-send/ubuntu trusty main\n
# deb-src http://ppa.launchpad.net/mattn/gntp-send/ubuntu trusty main" | \
	sudo tee /etc/apt/sources.list.d/mattn-ubuntu-gntp-send.list;
sudo apt update;

sudo apt install gntp-send -y;
