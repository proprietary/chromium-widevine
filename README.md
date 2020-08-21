# Note: This is a fork of proprietary/chromium-widevine that works on Ubuntu 20.04 / 20.04.1 LTS.

There is a [pull request](https://github.com/proprietary/chromium-widevine/pull/3) to get this upstream into [proprietary/chromium-widevine](https://github.com/proprietary/chromium-widevine).

Only tested on the instructions for `(easiest) Install Google Chrome and use its Widevine distribution` (see below).

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

```bash
git clone https://github.com/jarrellmark/chromium-widevine.git && \
	cd chromium-widevine && \
	./use-from-google-chrome.sh
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

