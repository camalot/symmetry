#!/usr/bin/env bash

if [ -d "$HOME/.ssh" ]; then
	if [ ! -f "$HOME/.ssh/authorized_keys" ]; then
		cp ".authorized_keys" "$HOME/.ssh/authorized_keys"
	else
		while IFS='' read -r line || [[ -n "$line" ]]; do
			if grep -Fxq "$line" "$HOME/.ssh/authorized_keys"; then
				echo "skipping '${line:8:16}' because it already exists"
			else
				echo "$line" >> "$HOME/.ssh/authorized_keys"
			fi
		done < ".authorized_keys"
	fi
fi
