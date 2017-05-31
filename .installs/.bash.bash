
if command -v uname > /dev/null; then
	case $(uname -s | awk '{print tolower($0)}') in
		darwin)
			brew install bash
			shift
		;;
		microsoft|pi|ubuntu|debian)
			apt install bash
			shift
		;;
	esac
fi

if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
	sudo -s
	echo /usr/local/bin/bash >> /etc/shells
	chsh -s /usr/local/bin/bash
fi
