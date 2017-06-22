#!/usr/bin/env bash

_install_headphones() {
	local INSTALL_PATH="/var/headphones";
	local hpuser="headphones";
	sudo mkdir -p $INSTALL_PATH;
	if ! id -u $hpuser > /dev/null 2>&1; then
		sudo adduser --system --no-create-home $hpuser;
		sudo adduser $hpuser audio;
	fi

	sudo git clone https://github.com/rembo10/headphones.git $INSTALL_PATH;
	sudo chown $hpuser:audio -Rv $INSTALL_PATH;

	sudo touch /etc/default/headphones;

	sudo echo "HP_USER=${hpuser}" > /etc/default/headphones;
	sudo echo "HP_HOME=${INSTALL_PATH}" >> /etc/default/headphones;
	sudo echo "HP_DATA=${INSTALL_PATH}" >> /etc/default/headphones;
	sudo echo "HP_OPTS=" >> /etc/default/headphones;
	sudo echo "HP_PORT=8181" >> /etc/default/headphones;

	sudo chmod +x $INSTALL_PATH/init-scripts/init.ubuntu;
	sudo ln -s $INSTALL_PATH/init-scripts/init.ubuntu /etc/init.d/headphones;
	sudo update-rc.d headphones defaults;
	sudo update-rc.d headphones enable;
}

_install_headphones;
