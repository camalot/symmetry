#!/usr/bin/env bash
source $HOME/.symmetry/functions/._symmetry.bash

__symmetry_info "$BASH_SOURCE";

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

# for b in $HOME/bin/*; do
# 	chmod +x $b;
# done

chmod +x $HOME/bin/symmetry;
chmod +x $HOME/bin/powershell;
chmod +x $HOME/bin/keychain;
chmod +x $HOME/bin/clip;
