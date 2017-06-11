
if [ ! -d "$HOME/OctoPrint" ]; then
	S_GROUP=$(id -g);

	sudo apt install python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential -y;
	git clone https://github.com/foosel/OctoPrint.git ~/OctoPrint;

	virtualenv $HOME/OctoPrint/venv;
	$HOME/OctoPrint/venv/bin/pip install pip --upgrade;
	$HOME/OctoPrint/venv/bin/python setup.py install;
	mkdir -p $HOME/.octoprint;

	chown $USER:$S_GROUP $HOME/OctoPrint;
	chown $USER:$S_GROUP $HOME/.octoprint;

	usermod -a -G tty pi;
	usermod -a -G dialout pi;
	unset S_GROUP;
fi
