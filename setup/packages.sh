#!/usr/bin/env bash

set -euo pipefail

# packages ======================================================================================

export PACKAGES=(
  # dependencies
  curl                      # setup
  dbus                      # desktop
  cargo                     # blink.cmp
  xwayland-satellite        # mango
  gsettings-desktop-schemas # gtk
  xdg-desktop-portal-wlr    # mango

  # graphical
  mangowc
  helium
  foot

  # console
  jujutsu
  gnupg
  unzip
  git

  # terminal
  wiremix
  neovim

  # video
  v4l2loopback
  obs

  # shell
  eza
  fd

  # dev
  shfmt
  shellcheck

  # fonts
  # TODO: maple mono nf
  noto-fonts-cjk-sans
  noto-fonts-emoji
  noto-fonts-ttf
)
