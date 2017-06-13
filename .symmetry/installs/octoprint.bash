
_octoprint_install() {
	if [ ! -d "$HOME/OctoPrint" ]; then
		sudo apt install python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential -y;
		git clone https://github.com/foosel/OctoPrint.git $HOME/OctoPrint;

		virtualenv $HOME/OctoPrint/venv;
		$HOME/OctoPrint/venv/bin/pip install pip --upgrade;
		$HOME/OctoPrint/venv/bin/python setup.py install;
		mkdir -p $HOME/.octoprint;

		usermod -a -G tty pi;
		usermod -a -G dialout pi;
	fi
}

_octoprint_install;

unset _octoprint_install;
