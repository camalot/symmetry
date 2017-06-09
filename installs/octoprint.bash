
if [ ! -d "$HOME/OctoPrint" ]; then
	cd ~
	apt install python-pip python-dev python-setuptools python-virtualenv git libyaml-dev build-essential -y;
	git clone ssh://git@github.com/foosel/OctoPrint.git
	cd OctoPrint
	virtualenv venv
	./venv/bin/pip install pip --upgrade
	./venv/bin/python setup.py install
	mkdir -p ~/.octoprint

	chown $USER:$USER ~/OctoPrint
	chown $USER:$USER ~/.octoprint

	usermod -a -G tty pi
	usermod -a -G dialout pi
fi
