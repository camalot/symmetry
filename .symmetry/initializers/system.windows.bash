#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash
source $HOME/.symmetry/functions/system.windows.bash;

__symmetry_info "$BASH_SOURCE";
if [[ ! $(__symmetry_platform) =~ ^windows\.?(suse|debian|ubuntu)?$ ]]; then
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
WIN_DESKTOP=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command '[Environment]::GetFolderPath("Desktop")' 2> /dev/null || echo "$WIN_USERPROFILE_PATH\Desktop");
WIN_ONEDRIVE=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command "Write-Host \$ENV:ONEDRIVE" 2> /dev/null || echo "$WIN_USERPROFILE_PATH\\OneDrive");

# if it matters, on macos and linux style systems, the info.json file is located at ~/.dropbox/info.json
WIN_DROPBOX=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command 'Get-Content "$ENV:LOCALAPPDATA\Dropbox\info.json" -ErrorAction Stop | ConvertFrom-Json | % personal | % path' 2> /dev/null || echo "$WIN_USERPROFILE_PATH\\Dropbox");
WIN_BOXSYNC="$WIN_USERPROFILE_PATH\\Box Sync";
WIN_GOOGLEDRIVE="$WIN_USERPROFILE_PATH\\Google Drive";

WIN_DOWNLOAD=$(powershell.exe -NoLogo -ExecutionPolicy Bypass -NoProfile -Command '[Environment]::GetFolderPath("Downloads")' 2> /dev/null || echo "$WIN_USERPROFILE_PATH\\Downloads");

# WIN_PATH_DEVELOPMENT is set in .symmetryconfig
if [[ $WIN_PATH_DEVELOPMENT ]]; then
	lxss_development=$(windir "$WIN_PATH_DEVELOPMENT");
	if [ -e "$lxss_development" ]; then
		if [ ! -L "$HOME/Development" ]; then
			echo "mapping $HOME/Development => $lxss_development";
			ln -s "$lxss_development" "$HOME/Development";
		fi
	fi
	unset lxss_development;
fi
mkdir -p "$HOME/Development";

lxss_win_desktop=$(windir "$WIN_DESKTOP");
if [ -e "$lxss_win_desktop" ]; then
	if [ ! -e "$HOME/Desktop" ]; then
		echo "mapping $HOME/Desktop => $lxss_win_desktop";
		ln -s "$lxss_win_desktop" "$HOME/Desktop";
	fi
fi
mkdir -p "$HOME/Desktop";
unset lxss_win_desktop;
unset WIN_DESKTOP;

lxss_win_downloads=$(windir "$WIN_DOWNLOAD");
if [ -e "$lxss_win_downloads" ]; then
	if [ ! -e "$HOME/Downloads" ]; then
		echo "mapping $HOME/Downloads => $lxss_win_downloads";
		ln -s "$lxss_win_downloads" "$HOME/Downloads";
	fi
fi
mkdir -p "$HOME/Downloads";
unset lxss_win_downloads;
unset WIN_DOWNLOAD;

# when this gets set, it has some whitespace at the end that needs to be removed.
lxss_win_dropbox=$(windir "$WIN_DROPBOX" | tr -d "\n\r" );
if [ -e "$lxss_win_dropbox" ]; then
	if [ ! -e "$HOME/Dropbox" ]; then
		echo "mapping $HOME/Dropbox => $lxss_win_dropbox";
		ln -s "$lxss_win_dropbox" "$HOME/Dropbox";
	fi
fi
unset lxss_win_dropbox;
unset WIN_DROPBOX;

lxss_win_boxsync=$(windir "$WIN_BOXSYNC");
if [ -e "$lxss_win_boxsync" ]; then
	if [ ! -e "$HOME/Box Sync" ]; then
		echo "mapping $HOME/Box Sync => $lxss_win_boxsync";
		ln -s "$lxss_win_boxsync" "$HOME/Box Sync";
	fi
fi
unset lxss_win_boxsync;
unset WIN_BOXSYNC;

lxss_win_onedrive=$(windir "$WIN_ONEDRIVE");
if [ -e "$lxss_win_onedrive" ]; then
	if [ ! -e "$HOME/OneDrive" ]; then
		echo "mapping $HOME/OneDrive => $lxss_win_onedrive"
		ln -s "$lxss_win_onedrive" "$HOME/OneDrive";
	fi
fi
unset lxss_win_onedrive;
unset WIN_ONEDRIVE;

lxss_win_googledrive=$(windir "$WIN_GOOGLEDRIVE");
if [ -e "$lxss_win_googledrive" ]; then
	if [ ! -e "$HOME/Google Drive" ]; then
		echo "mapping $HOME/Google Drive => $lxss_win_googledrive"
		ln -s "$lxss_win_googledrive" "$HOME/Google Drive";
	fi
fi
unset lxss_win_googledrive;
unset WIN_GOOGLEDRIVE;

lxss_win_userprofile=$(windir "$WIN_USERPROFILE_PATH");
if [ -e "$lxss_win_userprofile/.ssh" ]; then
	if [ ! -e "$HOME/.ssh" ]; then
		if [ -d "$HOME/.ssh" ]; then
			mv "$HOME/.ssh" "$HOME/.ssh.old/";
		fi
		echo "mapping $HOME/.ssh => $lxss_win_userprofile/.ssh"
		ln -s "$lxss_win_userprofile/.ssh" "$HOME/.ssh";
		chmod 0600 "$HOME/.ssh/id_rsa";
		chmod 0600 "$HOME/.ssh/id_rsa.pub";
	fi
fi

mkdir -p "$HOME/.ssh";

if [ -e "$lxss_win_userprofile/.aws" ]; then
	if [ ! -e "$HOME/.aws" ]; then
		echo "mapping $HOME/.aws => $lxss_win_userprofile/.aws"
		ln -s "$lxss_win_userprofile/.aws" "$HOME/.aws";
	fi
fi

if [ -e "$lxss_win_userprofile/.azure" ]; then
	if [ ! -e "$HOME/.azure" ]; then
		echo "mapping $HOME/.azure => $lxss_win_userprofile/.azure"
		ln -s "$lxss_win_userprofile/.azure" "$HOME/.azure";
	fi
fi

unset lxss_win_userprofile;
unset WIN_USERPROFILE_PATH;
