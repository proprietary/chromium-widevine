#!/bin/bash

# Detect wget/curl
DLTOOL=""
which wget && DLTOOL="wget -O -"
which curl && DLTOOL="curl -L"
[[ -z ${DLTOOL} ]] && echo "No download tool found on this system" 1>&2 && exit 1

# Set ARCH variable
ARCH=""
case `uname -m` in
	i?86)
		ARCH="ia32"
		VERSION=$(${DLTOOL} https://dl.google.com/widevine-cdm/versions.txt | tail -n10 | head -1)
		;;
	x86_64)
		ARCH="x64"
		VERSION=$(${DLTOOL} https://dl.google.com/widevine-cdm/versions.txt | tail -n1)
		;;
esac

[[ -z ${ARCH} ]] && echo "Architecture not supported" 1>&2 && exit 1
# Begin download
# Fix download argument for wget
DARG=${@}
[[ ${DLTOOL} == "wget -O -" ]] && DARG=`echo ${DARG} | sed 's/\-o /\-O /'` && DLTOOL="wget"
${DLTOOL} ${DARG} "https://dl.google.com/widevine-cdm/${VERSION}-linux-${ARCH}.zip"
