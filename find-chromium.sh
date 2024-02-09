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
or
Centos Red Hat Entreprise Alma Linux or Other fork:
require enable RPM Fussion https://rpmfusion.org/Configuration
$ sudo yum -y install epel-release
$ sudo yum -y install --nogpgcheck https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm
$ sudo yum -y update
$ sudo yum install chromium
or
Fedora:
require enable RPM Fussion https://rpmfusion.org/Configuration
$ sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
$ sudo dnf -y update
$ sudo dnf install chromium

EOF
	exit 1
fi

if [ -d /usr/lib/chromium ]; then
	# Debian
	CHROMIUM_DIR=/usr/lib/chromium
elif [ -d /usr/lib/chromium-browser ]; then
	# Ubuntu
	CHROMIUM_DIR=/usr/lib/chromium-browser
elif [ -d /usr/lib64/chromium-browser ]; then
	# Fedoara or Centos or Red Hat Entreprise or Other fork
	CHROMIUM_DIR=/usr/lib64/chromium-browser
elif [ -d $HOME/snap/chromium/current/.local ]; then
	# Snap
	mkdir -p $HOME/snap/chromium/current/.local/lib
	CHROMIUM_DIR=$HOME/snap/chromium/current/.local/lib
else
	>&2 echo <<EOF
Where is lib/ for chromium installed? Couldn't find it on the normal paths like:
/usr/lib/chromium
/usr/lib/chromium-browser
/usr/lib64/chromium-browser
$HOME/snap/chromium/current/local/lib

Edit ./find-chromium.sh and set CHROMIUM_DIR to that directory.
EOF
	exit 1
fi

echo $CHROMIUM_DIR

