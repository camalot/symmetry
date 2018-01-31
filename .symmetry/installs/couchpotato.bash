#!/usr/bin/env bash

_install_couchpotato() {
	sudo apt install build-dep python2-lxml python3-lxml -y;
	sudo pip install --upgrade pyopenssl;

	local install_dir="/var/couchpotato";

	local cpuser="couchpotato";
	sudo mkdir -p $install_dir;
	if ! id -u $cpuser > /dev/null 2>&1; then
		sudo adduser --system --no-create-home $cpuser;
		sudo adduser $cpuser media;
	fi


	git clone https://github.com/CouchPotato/CouchPotatoServer.git ${install_dir};
	sudo cp ${install_dir}/init/ubuntu /etc/init.d/couchpotato;
	sudo touch /etc/default/couchpotato;
	sudo tee -a /etc/default/couchpotato <<EOF
# username to run couchpotato under (couchpotato)
CP_USER=${cpuser}
# directory of CouchPotato.py (/opt/couchpotato)
CP_HOME=${install_dir}
# directory of couchpotato's db, cache and logs (/var/opt/couchpotato)
CP_DATA=${install_dir}/data
# full path of couchpotato.pid (/var/run/couchpotato/couchpotato.pid)
CP_PIDFILE=
# full path of the python binary (/usr/bin/python)
PYTHON_BIN=
# extra cli options for couchpotato, see 'CouchPotato.py --help'
CP_OPTS=
# extra options for start-stop-daemon, see 'man start-stop-daemon'
SSD_OPTS=
EOF
	sudo chmod +x /etc/init.d/couchpotato;
	sudo update-rc.d couchpotato defaults

	sudo chown -Rv $cpuser:media ${install_dir};

	sudo /etc/init.d/couchpotato start;

}

_install_couchpotato;
