#!/usr/bin/env bash
sudo apt install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y;
if [ ! -f '/root/jcameron-key.asc' ]; then
	sudo wget -O /root/jcameron-key.asc http://www.webmin.com/jcameron-key.asc;
	sudo apt-key add /root/jcameron-key.asc;
fi
if [ ! -f '/etc/apt/sources.list.d/webminsource.list' ]; then
	sudo echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webminsource.list;
	sudo apt update;
fi
sudo apt install webmin -y;
