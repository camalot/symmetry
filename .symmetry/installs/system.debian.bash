#!/usr/bin/env bash
sudo echo "Initializing Install";

sudo apt install software-properties-common python-software-properties -y;

sudo apt update;
sudo apt upgrade -y;

sudo apt install build-essential checkinstall -y;

sudo apt install pcregrep -y;
sudo apt install zip unzip -y;
sudo apt install socat -y;

source $PWD/.symmetry/installs/bash.bash;
source $PWD/.symmetry/installs/ruby.bash;

source $PWD/.symmetry/installs/python3.bash;

sudo apt install jq -y;

source $PWD/.symmetry/installs/node.bash;

source $PWD/.symmetry/installs/webmin.bash;


sudo apt install thefuck -y;
if ! command -v 'thefuck' 2> /dev/null; then
	pip3 install thefuck -U
fi

S_GROUP=$(id -g -n $USER);
mkdir -p $HOME/bin;

sudo pip install --upgrade awscli;
sudo pip install pylint behave --upgrade;

sudo chown $USER:$S_GROUP -r $HOME/bin;
sudo chown $USER:$S_GROUP $HOME/.local;
sudo chown $USER:$S_GROUP $HOME/.config;
sudo chown $USER:$S_GROUP $HOME/.rbenv;

unset S_GROUP;

sudo chmod 0755 $HOME/bin -R;
sudo chmod 0755 $HOME/.local -R;
sudo chmod 0755 $HOME/.config -R;
sudo chmod 0755 $HOME/.rbenv -R;

sudo apt autoremove -y;
