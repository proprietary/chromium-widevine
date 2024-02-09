#!/bin/bash
if [ -d "/cygdrive/c/Program Files/chromium" ]; then
	CHROMIUM_DIR="/cygdrive/c/Program Files/chromium"
elif [ -d "/cygdrive/c/Program Files/chromium-browser" ]; then
	CHROMIUM_DIR="/cygdrive/c/Program Files/chromium-browser"
elif [ -d "/cygdrive/c/Program Files (x86)/chromium" ]; then
	CHROMIUM_DIR="/cygdrive/c/Program Files (x86)/chromium"
elif [ -d "/cygdrive/c/Program Files (x86)/chromium-browser" ]; then
	CHROMIUM_DIR="/cygdrive/c/Program Files (x86)/chromium-browser"
fi
echo $CHROMIUM_DIR

