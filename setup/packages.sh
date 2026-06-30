#!/usr/bin/env bash

set -euo pipefail

# packages ======================================================================================

PACKAGES=(
  curl # setup
  dbus # desktop
  cargo # blink.cmp
  xwayland-satellite # mango
  gsettings-desktop-schemas # gtk
  xdg-desktop-portal-wlr # mango

  noto-fonts-cjk-sans
  noto-fonts-emoji
  noto-fonts-ttf

  v4l2loopback
  mangowc
  jujutsu
  wiremix
  helium
  neovim
  gnupg
  unzip
  foot
  obs
  git
  eza
  zvm
  fd
)
