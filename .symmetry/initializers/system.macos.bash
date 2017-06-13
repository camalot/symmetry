#!/usr/bin/env bash

source $HOME/.symmetry/functions/._symmetry.bash

__symmetry_info "$BASH_SOURCE";

mkdir -p "$HOME/iCloud";

MAC_ICLOUD="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
if [ -d "$MAC_ICLOUD" ]; then
	if [ ! -L "$HOME/iCloud/Documents" ]; then
		echo "mapping '$HOME/iCloud/Documents' => '$MAC_ICLOUD'";
		ln -s "$MAC_ICLOUD" "$HOME/iCloud/Documents";
	fi
else
	echo "$MAC_ICLOUD is not a directory";
fi

MAC_ICLOUD="$HOME/Library/Mobile Documents/com~apple~ScriptEditor2/Documents"
if [ -d "$MAC_ICLOUD" ]; then
	if [ ! -L "$HOME/iCloud/Script Editor" ]; then
		echo "mapping '$HOME/iCloud/Script Editor' => '$MAC_ICLOUD'";
		ln -s "$MAC_ICLOUD" "$HOME/iCloud/Script Editor";
	fi
else
	echo "$MAC_ICLOUD is not a directory";
fi
unset MAC_ICLOUD;

__symmetry_notice "\tTo set macOS defaults run:\n\t'symmetry init macos.default'";
