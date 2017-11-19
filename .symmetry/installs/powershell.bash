#!/usr/bin/env bash

PS_VERSION='6.0.0-beta.2';

if [ "$#" -gt 0 ]; then
	PS_VERSION="$1";
fi

case $(__symmetry_platform) in
	macos|darwin)
		# https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-beta.2/powershell-6.0.0-beta.2-osx.10.12-x64.pkg
		wget -P "$HOME/" "https://github.com/PowerShell/PowerShell/releases/download/v${PS_VERSION}/powershell-${PS_VERSION}-osx.10.12-x64.pkg";
		sudo installer -pkg "$HOME/powershell-${PS_VERSION}-osx.10.12-x64.pkg" -verbose -target "/";
		rm "$HOME/powershell-${PS_VERSION}-osx.10.12-x64.pkg";
	;;
	windows|pi|ubuntu|debian)
		wget -P "$HOME/" "https://github.com/PowerShell/PowerShell/releases/download/v${PS_VERSION}/powershell_${PS_VERSION}-1ubuntu1.16.04.1_amd64.deb";
		sudo apt-get install libunwind8 libicu55;
		sudo dpkg -i "$HOME/powershell_${PS_VERSION}-1ubuntu1.16.04.1_amd64.deb";
		rm "$HOME/powershell_${PS_VERSION}-1ubuntu1.16.04.1_amd64.deb";
	;;
	*)
		echo "Unknown platform: $(__symmetry_platform)";
		__symmetry_notice "System not currently supported. Type installing via\nhttps://github.com/PowerShell/PowerShell";
		exit 1;
	;;
esac
