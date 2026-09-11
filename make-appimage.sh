#!/bin/sh

set -eu

ARCH=$(uname -m)
#VERSION=$(pacman -Q PACKAGENAM | awk '{print $2; exit}') # example command to get version of application here
VERSION="0.0.1"
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=DUMMY
export DESKTOP=DUMMY
export MAIN_BIN=maim
# Deploy dependencies
quick-sharun \
  /usr/bin/maim \
  /usr/bin/slop \
  /usr/bin/grim \
  /usr/bin/slurp 

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --simple-test ./dist/*.AppImage
