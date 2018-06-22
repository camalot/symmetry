#!/usr/bin/env bash

if command -v docker > /dev/null; then
	alias docvker=docker;
	alias dovker=docker;
	alias docekr=docker;
	alias dockver=docker;
	alias dicker=docker;


	# some aliases that use docker
	alias yamllint="docker run --user 0 --rm -v \$(pwd):/work -w /work -it boiyaa/yamllint:latest";
	if ! command -v shellcheck > /dev/null; then
		alias shellcheck="docker run --user 0 --rm -v \$(pwd):/work -it -w /work koalaman/shellcheck:latest";
	fi
	if ! command -v dotnet > /dev/null; then
		alias dotnet="docker run --rm -v \$(pwd):/work --workdir /work -it microsoft/dotnet:latest dotnet";
	fi

	if ! command -v pwsh > /dev/null; then
		alias pwsh="docker run --rm -v \$(pwd):/work --workdir /work -it --entrypoint=/usr/bin/pwsh microsoft/powershell:latest";
	fi
fi
