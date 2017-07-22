#!/usr/bin/env bash

_install_webmin() {
	source $HOME/.symmetry/functions/._symmetry.bash;

	__symmetry_info "$BASH_SOURCE";
	if ! command -v apt-get > /dev/null 2>&1; then
		__symetry_notice "Platform not supported";
		return;
	fi
	sudo apt install perl libhtml-parser-perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y;
	if [ ! -f '/root/jcameron-key.asc' ]; then
		sudo wget -O /root/jcameron-key.asc http://www.webmin.com/jcameron-key.asc;
		sudo apt-key add /root/jcameron-key.asc;
	fi
	if [ ! -f '/etc/apt/sources.list.d/webminsource.list' ]; then
		sudo echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webminsource.list;
		sudo apt update;
	fi
	sudo apt install webmin -y;
}

_install_webmin;
