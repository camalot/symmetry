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

	echo "HP_USER=${hpuser}" | sudo tee /etc/default/headphones;
	echo "HP_HOME=${INSTALL_PATH}" | sudo tee -a /etc/default/headphones;
	echo "HP_DATA=${INSTALL_PATH}" | sudo tee -a /etc/default/headphones;
	echo "HP_OPTS=" | sudo tee -a /etc/default/headphones;
	echo "HP_PORT=8181" | sudo tee -a /etc/default/headphones;
	echo "HP_HOST=0.0.0.0" | sudo tee -a /etc/default/headphones;

	sudo chmod +x $INSTALL_PATH/init-scripts/init.ubuntu;
	if [ ! -L "/etc/init.d/headphones" ] && [ -f "$INSTALL_PATH/init-scripts/init.ubuntu"]; then
		sudo ln -s $INSTALL_PATH/init-scripts/init.ubuntu /etc/init.d/headphones;
	fi
	sudo update-rc.d headphones defaults;
	sudo update-rc.d headphones enable;
}

_install_headphones;
