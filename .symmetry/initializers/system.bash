#!/usr/bin/env bash
echo "begin symmetry initialization";

source $HOME/.symmetry/functions/._symmetry.bash

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

SYMMETRY_PLATFORM=$(dotfiles_platform);
if [ -f $HOME/.symmetry/initializers/$SYMMETRY_PLATFORM.bash ]; then
	echo "begin symmetry initialization for '$SYMMETRY_PLATFORM'";

	source $HOME/.symmetry/initializers/$SYMMETRY_PLATFORM.bash;
fi
unset SYMMETRY_PLATFORM;

echo "symmetry initialization complete";
