
_octoprint_install() {
	if [ ! -d "$HOME/OctoPrint" ]; then
		sudo apt install python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential -y;
		sudo apt install subversion libjpeg62-turbo-dev imagemagick libav-tools libv4l-dev cmake;
		git clone https://github.com/jacksonliam/mjpg-streamer.git $HOME/mjpg-streamer;
		pushd;
		export LD_LIBRARY_PATH=.;
		cd $HOME/mjpg-streamer/mjpg-streamer-experimental;
		make;
		popd;
		git clone https://github.com/foosel/OctoPrint.git $HOME/OctoPrint;

		virtualenv $HOME/OctoPrint/venv;
		$HOME/OctoPrint/venv/bin/pip install pip --upgrade;
		$HOME/OctoPrint/venv/bin/python setup.py install;
		mkdir -p $HOME/.octoprint;

		sudo cp $HOME/OctoPrint/scripts/octoprint.init /etc/init.d/octoprint;
		sudo chmod +x /etc/init.d/octoprint;
		sudo cp $HOME/OctoPrint/scripts/octoprint.default /etc/default/octoprint;

		sudo sed \
			-e 's|#PORT=5000|PORT=80' \
			-e "s|#DAEMON=$HOME/OctoPrint/venv/bin/octoprint|DAEMON=$HOME/OctoPrint/venv/bin/octoprint" \
			-e "s|#CONFIGFILE=$HOME/.octoprint/config.yaml|CONFIGFILE=$HOME/.octoprint/config.yaml" \
			-e "s|#BASEDIR=$HOME/.octoprint|BASEDIR=$HOME/.octoprint" \
			/etc/default/octoprint > /etc/default/octoprint;

		usermod -a -G tty pi;
		usermod -a -G dialout pi;

		sudo update-rc.d octoprint defaults;

		[[ -f /etc/rc.local ]] &&	sudo sed \
			-e "s|exit 0|$HOME/scripts/webcam start;\nexit 0;" /etc/rc.local > /etc/rc.local;

		sudo systemctl start octorprint;

	fi
}

_octoprint_install;

unset _octoprint_install;
