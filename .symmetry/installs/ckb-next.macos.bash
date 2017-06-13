#!/usr/bin/env bash

# CKB NEXT is a tool for using Corsair Mouse and/or Keyboards on macos / linux.
# https://github.com/mattanger/ckb-next
# CKB NEXT is a fork of CKB
# https://github.com/ccMSC/ckb


CKB_VERSION='0.2.8';

wget -P "$HOME/" "https://github.com/mattanger/ckb-next/releases/download/v${CKB_VERSION}/ckb-v${CKB_VERSION}.pkg"
sudo installer -pkg "$HOME/ckb-v${CKB_VERSION}.pkg" -verbose -target "/";
rm "$HOME/ckb-v${CKB_VERSION}.pkg";

unset CKB_VERSION;
