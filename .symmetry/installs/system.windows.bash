#!/usr/bin/env bash
sudo echo "Initializing Install";

sudo apt install software-properties-common python-software-properties -y
sudo add-apt-repository ppa:fkrull/deadsnakes -y
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

sudo apt update;
sudo apt upgrade -y;

sudo apt install build-essential checkinstall -y;

source $PWD/installs/bash.bash;
source $PWD/installs/ruby.bash;
source $PWD/installs/gems.bash;
source $PWD/installs/python3.bash;

sudo apt install python3-pip -y;
pip3 install -U setuptools;

sudo apt install nodejs;

sudo npm install npm -g -u;
sudo npm install -g grunt jasmine codecov;

sudo apt install thefuck -y;
if ! command -v 'thefuck' 2> /dev/null; then
	pip3 install thefuck -U
fi

S_GROUP=$(id -g);
mkdir -p $HOME/bin;
sudo chown $USER:$S_GROUP $HOME/bin;
# install screenfetch latest
wget -P ~/ https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev;
mv $HOME/screenfetch-dev $HOME/bin/screenfetch;
sudo chmod +x $HOME/bin/screenfetch;

wget -P $HOME/ https://raw.githubusercontent.com/raylee/tldr/master/tldr;
mv $HOME/tldr $HOME/bin/tldr;
sudo chown $USER:$S_GROUP $HOME/bin/tldr;
sudo chmod +x $HOME/bin/tldr;

sudo pip install --upgrade awscli;
sudo pip install pylint behave --upgrade;

sudo chown $USER:$S_GROUP $HOME/bin;
sudo chown $USER:$S_GROUP $HOME/.local;
sudo chown $USER:$S_GROUP $HOME/.config;
sudo chown $USER:$S_GROUP $HOME/.rbenv;

unset S_GROUP;

sudo apt autoremove -y;
