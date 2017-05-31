#!/usr/bin/env bash

[[ -x "$(command -v aws_completer)" ]] && complete -C "$(command -v aws_completer)" aws
