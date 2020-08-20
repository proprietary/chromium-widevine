#!/bin/bash

# Find Chromium and its library directory

if ! [ -x "$(command -v chromium)" ] && ! [ -x "$(command -v chromium-browser)" ]; then
	>&2 echo <<EOF
Neither `chromium` nor `chromium-browser` found on PATH.

Debian:
$ sudo apt install chromium
or
Ubuntu:
$ sudo apt install chromium-browser
EOF
	exit 1
fi

if [ -d /usr/lib/chromium ]; then
	# Debian
	CHROMIUM_DIR=/usr/lib/chromium
elif [ -d /usr/lib/chromium-browser ]; then
	# Ubuntu
	CHROMIUM_DIR=/usr/lib/chromium-browser
elif [ -d $HOME/snap/chromium/current/.local ]; then
	# Snap
	mkdir -p $HOME/snap/chromium/current/.local/lib
	CHROMIUM_DIR=$HOME/snap/chromium/current/.local/lib
else
	>&2 echo <<EOF
Where is lib/ for chromium installed? Couldn't find it on the normal paths like:
/usr/lib/chromium
/usr/lib/chromium-browser
$HOME/snap/chromium/current/local/lib

Edit ./find-chromium.sh and set CHROMIUM_DIR to that directory.
EOF
	exit 1
fi

echo $CHROMIUM_DIR
