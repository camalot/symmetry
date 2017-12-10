#!/usr/bin/env bash
source $HOME/.symmetry/functions/._symmetry.bash

__symmetry_info "$BASH_SOURCE";


# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color";
	if [ -f "$HOME/.dircolors" ]; then
		eval $(dircolors "$HOME/.dircolors");
	else
		export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:';
	fi
else # macOS `ls`
	colorflag="-G";
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx';
fi

auth_keys=$HOME/.symmetry/initializers/.authorized_keys;
if [ -d "$HOME/.ssh" ] && [ -f $auth_keys ]; then
	if [ ! -f "$HOME/.ssh/authorized_keys" ]; then
		cp "$auth_keys" "$HOME/.ssh/authorized_keys"
	else
		while IFS='' read -r line || [[ -n "$line" ]]; do
			if grep -Fxq "$line" "$HOME/.ssh/authorized_keys"; then
				echo "skipping '${line:8:16}' because it already exists"
			else
				echo "$line" >> "$HOME/.ssh/authorized_keys"
			fi
		done < "$auth_keys"
	fi
fi


if command -v chef > /dev/null 2>&1; then
	eval $(chef shell-init $SHELL);
fi

chmod +x $HOME/bin/symmetry;
chmod +x $HOME/bin/powershell;
chmod +x $HOME/bin/keychain;
chmod +x $HOME/bin/clip;
