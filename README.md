# Installing Widevine on Chromium on GNU/Linux

Or: How to get Spotify/Netflix working on Chromium in Linux

Most distributions' package managers come with Chromium but without Widevine, a proprietary binary blob required for DRM protected content (e.g., Netflix or Spotify). Normally your only option to access DRM-protected content would be to use Google Chrome or Mozilla Firefox, but here are some alternate ways you can keep using stock Chromium.

Instructions are for Debian GNU/Linux amd64; should work for other Debian-based distros like Ubuntu.

## (easiest) Install Google Chrome and use its Widevine distribution

### Install Google Chrome **stable** (beta or unstable won't work)

Skip this if you already have it.

```bash
$ wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
$ echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
$ sudo apt update && sudo apt install -y google-chrome-stable
```

### Run script

The following script symlinks Google Chrome's Widevine library to Chromium's directory.

Paste this into your terminal:

For linux

```bash
git clone https://github.com/amidevous/chromium-widevine.git && \
	cd chromium-widevine && \
	sudo ./use-from-google-chrome.sh
```


```bash
wget https://github.com/amidevous/chromium-widevine/archive/refs/heads/master.tar.gz -O master.tar.gz && \
	tar -xvf master.tar.gz && rm -f master.tar.gz && \
	cd chromium-widevine-master && \
	sudo ./use-from-google-chrome.sh
```


```bash
git clone https://github.com/amidevous/chromium-widevine.git && \
	cd chromium-widevine && \
	sudo ./use-standalone-widevine.sh
```



```bash
wget https://github.com/amidevous/chromium-widevine/archive/refs/heads/master.tar.gz -O master.tar.gz && \
	tar -xvf master.tar.gz && rm -f master.tar.gz && \
	cd chromium-widevine-master && \
	sudo ./use-standalone-widevine.sh
```

For Windows Require and use on Cygwin Terminal (https://cygwin.org)

install https://cygwin.org/setup-x86_64.exe

minimal require package add wget, gzip, tar

open Cygwin Terminal in Admin Mode Require

enter command

```bash
wget https://github.com/amidevous/chromium-widevine/archive/refs/heads/master.tar.gz -O master.tar.gz && \
	gunzip master.tar.gz && tar -xvf master.tar && rm -f master.tar && \
	cd chromium-widevine-master && \
	./use-standalone-widevine-windows.sh
```


## Test Widevine

Paste into terminal (*warning: restarts Chromium*):

```bash
killall -q -SIGTERM chromium-browser || \
	killall -q -SIGTERM chromium && \
	exec $(command -v chromium-browser || command -v chromium) ./test-widevine.html &
```

…Or manually:

1. Restart Chromium. If it was already open, then go to [chrome://restart](chrome://restart).
2. Make sure Protected Content is enabled in settings: [chrome://settings/content/protectedContent](chrome://settings/content/protectedContent).
3. Open `test-widevine.html` from this cloned repo in Chromium.

…Alternatively, visit Netflix, Spotify, or $DEGENERATE_DRM_CONTENT_PROVIDER to see if it works directly.

# Limitations

- [Some streaming sites](https://web.archive.org/web/20191026132853/https://www.phoronix.com/scan.php?page=news_item&px=Disney-Plus-Not-On-Linux) refuse to run at all on Linux because the kernel does not provide access to chipset-level fencing of DRM decryption as provided by Microsoft and Apple systems.
- These scripts assume a standard instlalation from Debian/Ubuntu packages. If you installed Google Chrome or Chromium manually, you might have to edit the scripts.
- Because we are installing files directly to `/usr` (as opposed to the more appropriate `/usr/local`), and we have to for Chromium to find Widevine, on system upgrades your package manager might clobber these files, and you will have to redo these steps.
- These instructions only work for amd64 (64-bit x86_64) on GNU/Linux. For alternate architectures like ARM or i386 (32-bit x86), please fork this and submit a pull request.


## (alternative) Install Widevine alone without Google Chrome

Paste this into your shell:

```bash
rm -rf chromium-widevine && git clone https://github.com/amidevous/chromium-widevine.git && \
	cd chromium-widevine && \
	sudo ./use-standalone-widevine.sh && \
	killall -q -SIGTERM chromium-browser || \
	killall -q -SIGTERM chromium && \
	exec $(command -v chromium-browser || command -v chromium) ./test-widevine.html &
```

The first method using Google Chrome just copied one directory from its installation. Observe the Widevine directory in the Google Chrome distribution:

```text
/opt/google/chrome/WidevineCdm
├── LICENSE
├── manifest.json
└── _platform_specific
    └── linux_x64
	        └── libwidevinecdm.so
```

We don't actually need the whole Google Chrome installation. We can recreate that tree in the Chromium directory (i.e., `/usr/lib/chromium`) with a standalone distribution of the Widevine shared library. Copying just `libwidevinecdm.so` into `/usr/lib/chromium` doesn't work.

N.B. Disadvantage of this method: You might have to manually re-run this script whenever Chromium updates to get the latest Widevine. The first method piggybacks Google Chrome's distribution which is assumed to be up-to-date and updated by the same package manager that updates Chromium. Use that method unless you really don't want Google Chrome on your system.
