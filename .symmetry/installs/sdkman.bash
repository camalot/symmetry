
if command -v uname > /dev/null; then
	case $(uname -s | awk '{print tolower($0)}') in
		darwin)
			brew install zip unzip;
		;;
		microsoft|pi|ubuntu|debian)
			sudo apt install zip unzip -y;
		;;
	esac
fi

curl -s "https://get.sdkman.io" | bash;
