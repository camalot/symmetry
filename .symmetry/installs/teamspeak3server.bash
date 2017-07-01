#!/usr/bin/env bash

_install_ts3server() {
	local TS3S_VERSION='3.0.13.6';
	local TS3S_ARCH='amd64'; # x86 | amd64

	sudo useradd -d /opt/teamspeak3-server -m teamspeak3-user;
	local tar_ball="teamspeak3-server_linux_${TS3S_ARCH}-${TS3S_VERSION}.tar.bz2";
	sudo wget http://dl.4players.de/ts/releases/${TS3S_VERSION}/${tar_ball};
	sudo tar -jxvf $tar_ball;
	sudo mkdir /opt/teamspeak3-server;
	sudo mv teamspeak3-server_linux_${TS3S_ARCH}/* /opt/teamspeak3-server;
	sudo chown teamspeak3-user:teamspeak3-user /opt/teamspeak3-server -R;
	sudo rm -fr $tar_ball teamspeak3-server_linux_${TS3S_ARCH};


	sudo touch /opt/teamspeak3-server/query_ip_blacklist.txt;

	sudo cat <<EOT > /opt/teamspeak3-server/query_ip_whitelist.txt
127.0.0.1
EOT;

	sudo chown teamspeak3-user:teamspeak3-user /opt/teamspeak3-server -R


	sudo cat <<EOT > /etc/init.d/ts3
	#!/usr/bin/env bash
	### BEGIN INIT INFO
	# Provides:          ts3
	# Required-Start:    $network mysql
	# Required-Stop:     $network
	# Default-Start:     2 3 4 5
	# Default-Stop:      0 1 6
	# Short-Description: TeamSpeak3 Server Daemon
	# Description:       Starts/Stops/Restarts the TeamSpeak Server Daemon
	### END INIT INFO

	set -e

	PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
	DESC="TeamSpeak3 Server"
	NAME=teamspeak3-server
	USER=teamspeak3-user
	DIR=/opt/teamspeak3-server
	OPTIONS=inifile=ts3server.ini
	DAEMON=$DIR/ts3server_startscript.sh
	#PIDFILE=/var/run/$NAME.pid
	SCRIPTNAME=/etc/init.d/$NAME

	# Gracefully exit if the package has been removed.
	test -x $DAEMON || exit 0

	sleep 2
	sudo -u $USER $DAEMON $1 $OPTIONS
EOT;

	sudo chmod a+x /etc/init.d/ts3;
	sudo chmod a+x /opt/teamspeak3-server/ts3server_startscript.sh;
	sudo chmod a+x /opt/teamspeak3-server/ts3server_minimal_runscript.sh;
	sudo update-rc.d ts3 defaults;

	sudo /etc/init.d/ts3;
}

_install_ts3server;
