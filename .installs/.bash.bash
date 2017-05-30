
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

sudo -s
echo /usr/local/bin/bash >> /etc/shells
chsh -s /usr/local/bin/bash
