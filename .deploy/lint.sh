#!/usr/bin/env bash
base_dir=$(dirname "$0");

docker run \
	--user 0 \
	--rm \
	-e SHELLCHECK_OPTS="-e SC2086 -e SC2155 -e SC2002" \
	-it koalaman/shellcheck ${base_dir}../.symmetry/**/*.bash;
