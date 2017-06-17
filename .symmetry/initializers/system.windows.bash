#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash
source $HOME/.symmetry/functions/system.windows.bash;

__symmetry_info "$BASH_SOURCE";
if $(__symmetry_platform) != "windows" > /dev/null 2>&1; then
	__symetry_notice "Platform not supported";
	return;
fi


WIN_USER=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command "Write-Host \$ENV:USERNAME" 2> /dev/null || echo $USER);

if [[ ! $WIN_DEFAULT_USERDATA_DRIVE ]]; then
	export WIN_DEFAULT_USERDATA_DRIVE="c";
fi

echo "WIN_DEFAULT_USERDATA_DRIVE set to '$WIN_DEFAULT_USERDATA_DRIVE'";

WIN_USERPROFILE_PATH=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command "Write-Host \$ENV:USERPROFILE" 2> /dev/null || echo "$WIN_DEFAULT_USERDATA_DRIVE:\\Users\\$WIN_USER");

# these are all windows style paths. We will convert them later
WIN_DESKTOP=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command '[Environment]::GetFolderPath("Desktop")' 2> /dev/null || echo "$WIN_DEFAULT_USERDATA_DRIVE:\\Users\\$WIN_USER\\Desktop");
WIN_ONEDRIVE=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command "Write-Host \$ENV:ONEDRIVE" 2> /dev/null || echo "c:\\Users\\$WIN_USER\\OneDrive");

# if it matters, on macos and linux style systems, the info.json file is located at ~/.dropbox/info.json
WIN_DROPBOX=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command 'Get-Content "$ENV:LOCALAPPDATA\Dropbox\info.json" -ErrorAction Stop | ConvertFrom-Json | % personal | % path' 2> /dev/null || echo "$WIN_DEFAULT_USERDATA_DRIVE:\\Users\\$WIN_USER\\Dropbox");


WIN_BOXSYNC="$WIN_DEFAULT_USERDATA_DRIVE:\\Users\\$WIN_USER\\Box Sync";
WIN_GOOGLEDRIVE="$WIN_DEFAULT_USERDATA_DRIVE:\\Users\\$WIN_USER\\Google Drive";

WIN_DOWNLOAD=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command '[Environment]::GetFolderPath("Downloads")' 2> /dev/null || echo "$WIN_DEFAULT_USERDATA_DRIVE:\\Users\\$WIN_USER\\Downloads");

# WIN_PATH_DEVELOPMENT is set in .symmetryconfig
if [[ $WIN_PATH_DEVELOPMENT ]]; then
	lxss_development=$(windir "$WIN_PATH_DEVELOPMENT");
	if [ -d "$lxss_development" ]; then
		if [ ! -L "$HOME/Development" ]; then
			echo "mapping $HOME/Development => $lxss_development";
			ln -s "$lxss_development" "$HOME/Development";
		fi
	else
		echo "'$lxss_development' is not a directory";
	fi
	unset lxss_development;
else
	echo "WIN_PATH_DEVELOPMENT not configured in .symmetryconfig";
fi
mkdir -p "$HOME/Development";

lxss_win_desktop=$(windir "$WIN_DESKTOP");
if [ -d "$lxss_win_desktop" ]; then
	if [ ! -L "$HOME/Desktop" ]; then
		echo "mapping $HOME/Desktop => $lxss_win_desktop";
		ln -s "$lxss_win_desktop" "$HOME/Desktop";
	fi
else
	echo "'$lxss_win_desktop' is not a directory";
fi
mkdir -p "$HOME/Desktop";
unset lxss_win_desktop;
unset WIN_DESKTOP;

lxss_win_downloads=$(windir "$WIN_DOWNLOAD");
if [ -d "$lxss_win_downloads" ]; then
	if [ ! -L "$HOME/Downloads" ]; then
		echo "mapping $HOME/Downloads => $lxss_win_downloads";
		ln -s "$lxss_win_downloads" "$HOME/Downloads";
	fi
else
	echo "'$lxss_win_desktop' is not a directory";
fi
mkdir -p "$HOME/Downloads";
unset lxss_win_downloads;
unset WIN_DOWNLOAD;

# when this gets set, it has some whitespace at the end that needs to be removed.
lxss_win_dropbox=$(windir "$WIN_DROPBOX" | tr -d "\n\r" );
if [ -d "$lxss_win_dropbox" ]; then
	if [ ! -L "$HOME/Dropbox" ]; then
		echo "mapping $HOME/Dropbox => $lxss_win_dropbox";
		ln -s "$lxss_win_dropbox" "$HOME/Dropbox";
	fi
else
	echo "$lxss_win_dropbox is not a directory";
fi
unset lxss_win_dropbox;
unset WIN_DROPBOX;

lxss_win_boxsync=$(windir "$WIN_BOXSYNC");
if [ -d "$lxss_win_boxsync" ]; then
	if [ ! -L "$HOME/Box Sync" ]; then
		echo "mapping $HOME/Box Sync => $lxss_win_boxsync";
		ln -s "$lxss_win_boxsync" "$HOME/Box Sync";
	fi
else
	echo "$lxss_win_boxsync is not a directory";
fi
unset lxss_win_boxsync;
unset WIN_BOXSYNC;

lxss_win_onedrive=$(windir "$WIN_ONEDRIVE");
if [ -d "$lxss_win_onedrive" ]; then
	if [ ! -L "$HOME/OneDrive" ]; then
		echo "mapping $HOME/OneDrive => $lxss_win_onedrive"
		ln -s "$lxss_win_onedrive" "$HOME/OneDrive";
	fi
else
	echo "'$lxss_win_onedrive' is not a directory";
fi
unset lxss_win_onedrive;
unset WIN_ONEDRIVE;

lxss_win_googledrive=$(windir "$WIN_GOOGLEDRIVE");
if [ -d "$lxss_win_googledrive" ]; then
	if [ ! -L "$HOME/Google Drive" ]; then
		echo "mapping $HOME/Google Drive => $lxss_win_googledrive"
		ln -s "$lxss_win_googledrive" "$HOME/Google Drive";
	fi
else
	echo "'$lxss_win_googledrive' is not a directory";
fi
unset lxss_win_googledrive;
unset WIN_GOOGLEDRIVE;

lxss_win_userprofile=$(windir "$WIN_USERPROFILE_PATH");
if [ -d "$lxss_win_userprofile/.ssh" ]; then
	if [ ! -L "$HOME/.ssh" ]; then
		if [ -d "$HOME/.ssh" ]; then
			mv "$HOME/.ssh" "$HOME/.ssh.old/";
		fi
		echo "mapping $HOME/.ssh => $lxss_win_userprofile/.ssh"
		ln -s "$lxss_win_userprofile/.ssh" "$HOME/.ssh";
		chmod 0600 "$HOME/.ssh/id_rsa";
		chmod 0600 "$HOME/.ssh/id_rsa.pub";
	fi
else
	echo "'$lxss_win_userprofile/.ssh' is not a directory";
fi

mkdir -p "$HOME/.ssh";


if [ -d "$lxss_win_userprofile/.aws" ]; then
	if [ ! -L "$HOME/.aws" ]; then
		echo "mapping $HOME/.aws => $lxss_win_userprofile/.aws"
		ln -s "$lxss_win_userprofile/.aws" "$HOME/.aws";
	fi
else
	echo "'$lxss_win_userprofile/.aws' is not a directory";
fi

if [ -d "$lxss_win_userprofile/.azure" ]; then
	if [ ! -L "$HOME/.azure" ]; then
		echo "mapping $HOME/.azure => $lxss_win_userprofile/.azure"
		ln -s "$lxss_win_userprofile/.azure" "$HOME/.azure";
	fi
else
	echo "'$lxss_win_userprofile/.azure' is not a directory";
fi

unset lxss_win_userprofile;
unset WIN_USERPROFILE_PATH;
