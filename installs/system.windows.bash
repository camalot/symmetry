#!/usr/bin/env bash
apt install software-properties-common python-software-properties -y
add-apt-repository ppa:fkrull/deadsnakes -y
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

apt update;
apt upgrade -y;

apt install build-essential checkinstall -y;

source $PWD/installs/bash.bash;
source $PWD/installs/ruby.bash;
source $PWD/installs/gems.bash;
source $PWD/installs/python3.bash;

apt install python3-pip -y;
pip3 install -U setuptools;

apt install nodejs;

npm install npm -g -u;
npm install -g grunt jasmine codecov;

apt install thefuck -y;
if ! command -v 'thefuck' 2> /dev/null; then
	pip3 install thefuck -U
fi


mkdir -p $HOME/bin;
chown $USER:$USER $HOME/bin;
# install screenfetch latest
wget -P ~/ https://raw.githubusercontent.com/KittyKatt/screenFetch/master/screenfetch-dev;
mv $HOME/screenfetch-dev $HOME/bin/screenfetch;
chmod +x $HOME/bin/screenfetch;

wget -P $HOME/ https://raw.githubusercontent.com/raylee/tldr/master/tldr;
mv $HOME/tldr $HOME/bin/tldr;
chown $USER:$USER $HOME/bin/tldr;
chmod +x $HOME/bin/tldr;

pip install --upgrade awscli;
pip install pylint behave --upgrade;

apt autoremove;
