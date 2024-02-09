#!/bin/bash
CHROMIUM_DIR="$(/bin/sh ./find-chromium-windows.sh)"
if [ -z "$CHROMIUM_DIR" ]; then
	exit 1
fi

# Get Widevine archive
/bin/sh ./fetch-latest-widevine-windows.sh -o ./widevine.zip
# Expected directory structure:
#	  widevine.zip
#	  ├── LICENSE.txt
#	  ├── manifest.json
#	  └── widevinecdm.dll
#	  └── widevinecdm.dll.sig
#	  └── widevinecdm.dll.lib

# Extract Widevine and recreate this directory structure under the Chromium directory:
#	  /usr/lib/chromium/WidevineCdm
#	  ├── LICENSE
#	  ├── manifest.json
#	  └── _platform_specific
#		  └── win-x64
#				└── widevinecdm.dll
#				└── widevinecdm.dll.sig
#				└── widevinecdm.dll.lib

mkdir -p "$CHROMIUM_DIR/WidevineCdm/_platform_specific/win-x64/"
cd "$CHROMIUM_DIR/WidevineCdm/"
unzip widevine.zip
mkdir -p "${CHROMIUM_DIR}/WidevineCdm/LICENSE/"
mv LICENSE.txt "${CHROMIUM_DIR}/WidevineCdm/LICENSE/"
mv widevinecdm.dll "$CHROMIUM_DIR/WidevineCdm/_platform_specific/win-x64/"
mv widevinecdm.dll.sig "$CHROMIUM_DIR/WidevineCdm/_platform_specific/win-x64/"
mv widevinecdm.dll.lib "$CHROMIUM_DIR/WidevineCdm/_platform_specific/win-x64/"
# clean up
rm ./widevine.zip
