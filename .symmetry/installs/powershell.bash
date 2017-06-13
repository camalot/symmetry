#!/usr/bin/env bash

PS_VERSION='6.0.0-beta.2';

if [ "$#" -gt 0 ]; then
	PS_VERSION="$1";
fi

if $(__symmetry_platform) = "macos" > /dev/null 2>&1; then
	# https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-beta.2/powershell-6.0.0-beta.2-osx.10.12-x64.pkg
	wget -P "$HOME/" "https://github.com/PowerShell/PowerShell/releases/download/v${PS_VERSION}/powershell-${PS_VERSION}-osx.10.12-x64.pkg";
	sudo installer -pkg "$HOME/powershell-${PS_VERSION}-osx.10.12-x64.pkg" -verbose -target "/";
	rm "$HOME/powershell-${PS_VERSION}-osx.10.12-x64.pkg";
else
	if command -v apt-get > /dev/null 2>&1; then
		wget -P "$HOME/" "https://github.com/PowerShell/PowerShell/releases/download/v${PS_VERSION}/powershell_${PS_VERSION}-1ubuntu1.16.04.1_amd64.deb";
		sudo apt-get install libunwind8 libicu55;
		sudo dpkg -i "$HOME/powershell_${PS_VERSION}-1ubuntu1.16.04.1_amd64.deb";
		rm "$HOME/powershell_${PS_VERSION}-1ubuntu1.16.04.1_amd64.deb";
	else
		__symmetry_notice "System not currently supported. Type installing via\nhttps://github.com/PowerShell/PowerShell";
	fi
fi
