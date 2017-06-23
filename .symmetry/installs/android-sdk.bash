#!/usr/bin/env bash
_install_androidsdk() {
	local tool_version="3859397";
	local tool_platform="linux";
	local build_tools_verison="26.0.0";
	local platform_verison="android-26";

	if command -v uname > /dev/null; then
		case $(uname -s | awk '{print tolower($0)}') in
			darwin)
				tool_platform='darwin';
				brew cask install java;
			;;
			microsoft|pi|ubuntu|debian)
				tool_platform="linux";
				sudo add-apt-repository ppa:webupd8team/java;
				sudo apt update;
				sudo apt install oracle-java8-installer -y;
				sudo apt install lib32ncurses5 lib32stdc++6 -y;
			;;
			*)
				echo "unable to get the platform";
				exit 500;
			;;
		esac
	fi

	local local_file="sdk-tools-${tool_platform}-${tool_version}.zip";
	wget -P "$HOME/" "https://dl.google.com/android/repository/${local_file}";

	mkdir -p $HOME/Android/sdk;
	unzip -u "${HOME}/${local_file}" -d "$HOME/Android/sdk";

	rm "$HOME/${local_file}";
	export PATH="$HOME/Android/sdk/tools:$HOME/Android/sdk/tools/bin:$PATH";

	yes | sdkmanager "platform-tools" "build-tools;${build_tools_verison}" "platforms;${platform_verison}" "tools" --verbose;
	export PATH="$HOME/Android/sdk/platform-tools:$HOME/Android/sdk/emulator:$HOME/Android/sdk/build-tools/${build_tools_verison}:$PATH";
}

_install_androidsdk;
