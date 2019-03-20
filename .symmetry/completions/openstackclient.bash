#!/usr/bin/env bash

# ignore for moment as it is failing to load.
return;

if command -v openstack > /dev/null 2>&1; then
	$(openstack complete);
fi
