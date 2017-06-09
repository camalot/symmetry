#!/usr/bin/env bash

source $PWD/.functions/._symmetry.bash

auth_keys=$PWD/initializers/.authorized_keys;
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

SYMMETRY_PLATFORM=$(dotfiles_platform);
source $PWD/initializers/$SYMMETRY_PLATFORM.bash;
unset SYMMETRY_PLATFORM;
