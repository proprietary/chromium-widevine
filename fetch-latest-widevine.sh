#!/bin/bash

ARCH=x64 # or ia32
VERSION=$(curl -s https://dl.google.com/widevine-cdm/versions.txt | tail -n1)

curl -fsSL "$@" "https://dl.google.com/widevine-cdm/${VERSION}-linux-${ARCH}.zip"
