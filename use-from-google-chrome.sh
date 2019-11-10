#!/bin/bash

# Find Google Chrome
if ! [ -x "$(command -v google-chrome)" ]; then
	echo "google-chrome not found on PATH" >&2
	exit 1
fi
WIDEVINE_DIR="$(dirname $(realpath $(which google-chrome)))/WidevineCdm"
if ! [ -d "$WIDEVINE_DIR" ]; then
	echo "Can't find Widevine in your Google Chrome install"
	exit 1
fi
CHROMIUM_DIR="$(/bin/sh ./find-chromium.sh)"
if [ -z "$CHROMIUM_DIR" ]; then
	exit 1
fi
sudo ln -s $WIDEVINE_DIR $CHROMIUM_DIR/

