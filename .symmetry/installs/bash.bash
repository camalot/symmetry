#!/usr/bin/env bash

set -e;

case $(__symmetry_platform) in
	macos|darwin)
		brew install bash;
	;;
	windows|pi|ubuntu|debian)
		sudo apt install bash -y;
	;;
	*)
		echo "Unknown platform: $(__symmetry_platform)";
		exit 1;
	;;
esac

if [ -f "/usr/local/bin/bash" ]; then
	if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
		echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
	fi
	# even if it is in the /etc/shells file, we still need to set it as the current shell
	chsh -s /usr/local/bin/bash;
elif [ -f "/bin/bash" ]; then
	if ! fgrep -q '/bin/bash' /etc/shells; then
		sudo echo /bin/bash >> /etc/shells;
	fi
	# even if it is in the /etc/shells file, we still need to set it as the current shell
	sudo chsh -s /bin/bash;
else
	echo "Unable to locate the version of bash that was installed.";
	exit 1;
fi
