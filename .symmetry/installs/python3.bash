#!/usr/bin/env bash
RELEASE="3.6.1";

sudo apt install python-pip -y;

# install dependencies
sudo apt install libbz2-dev liblzma-dev libsqlite3-dev libncurses5-dev libgdbm-dev zlib1g-dev libreadline-dev libssl-dev tk-dev -y;

version=$(python -V 2>&1 | grep -Po '(?<=Python )(.+)');
if [[ -z "$RELEASE" ]]; then
	tdir=$PWD;
	# download and build Python
	mkdir -p $HOME/python3;
	wget -O $HOME/python3/Python-$RELEASE.tar.xz https://www.python.org/ftp/python/$RELEASE/Python-$RELEASE.tar.xz;
	tar xvf $HOME/python3/Python-$RELEASE.tar.xz;
	cd $HOME/python3/Python-$RELEASE;
	./configure;
	make;
	sudo make install;
	sudo rm -rf $HOME/python3/Python-$RELEASE;
	cd "$tdir";
fi

sudo apt install python3-pip -y;
sudo pip install --upgrade pip;
pip install -U setuptools;

unset RELEASE;
unset version;
