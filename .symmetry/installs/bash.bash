
if command -v uname > /dev/null; then
	case $(uname -s | awk '{print tolower($0)}') in
		darwin)
			brew install bash;
		;;
		microsoft|pi|ubuntu|debian)
			sudo apt install bash -y;
		;;
	esac
fi

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
fi
