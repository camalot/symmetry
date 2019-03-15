#!/usr/bin/env bash
if command -v openstack > /dev/null 2>&1; then
	$(openstack complete);
fi
