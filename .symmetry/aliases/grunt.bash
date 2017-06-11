#!/usr/bin/env bash
# Make Grunt print stack traces by default
command -v grunt > /dev/null && alias grunt="grunt --stack"
