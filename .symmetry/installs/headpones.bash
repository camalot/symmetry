#!/usr/bin/env bash
INSTALL_PATH="/var/headphones";

sudo mkdir -p $INSTALL_PATH;
sudo git clone https://github.com/rembo10/headphones.git $INSTALL_PATH;

sudo chown headphones:audio -Rv $INSTALL_PATH;

sudo touch /etc/default/headphones;

if ! id -u headphones > /dev/null 2>&1; then
	sudo adduser --system --no-create-home headphones;
	sudo adduser headphones audio;
fi

sudo chmod +x $INSTALL_PATH/init-scripts/init.ubuntu;
sudo ln -s $INSTALL_PATH/init-scripts/init.ubuntu /etc/init.d/headphones;
sudo update-rc.d headphones defaults;
sudo update-rc.d headphones enable;
