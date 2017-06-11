
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

if ! fgrep -q '/bin/bash' /etc/shells; then
	sudo echo /bin/bash >> /etc/shells;
	sudo chsh -s /bin/bash;
fi
