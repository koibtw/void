#!/usr/bin/env bash

set -euo pipefail

# packages ======================================================================================

export PACKAGES=(
  # dependencies
  xz                        # setup
  curl                      # setup
  dbus                      # desktop
  nodejs                    # npm packages
  git-lfs                   # git
  xwayland-satellite        # mango
  gsettings-desktop-schemas # gtk
  xdg-desktop-portal-wlr    # mango

  # graphical
  wl-clipboard
  mangowc
  helium
  halloy
  slurp
  grim
  foot

  # console
  jujutsu
  gnupg
  unzip
  just
  git
  jq

  # terminal
  wiremix
  neovim
  btop

  # video
  v4l2loopback
  obs
  mpv

  # dev
  shfmt
  rustup
  shellcheck
  xtools

  # net
  tailscale

  # fonts
  # TODO: maple mono nf
  noto-fonts-cjk-sans
  noto-fonts-emoji
  noto-fonts-ttf
)

# shell =========================================================================================

export SHELL_PACKAGES=(
  zoxide
  eza
  fd
)

export FISH_PACKAGES=(fish-shell)
export ZSH_PACKAGES=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh
)

# lsp ===========================================================================================

export LSP_PACKAGES=(
  bash-language-server
  lua-language-server
  just-lsp
  tombi
  yaml-language-server
)

# npm ===========================================================================================

export NPM_PACKAGES=(
  @zed-industries/vscode-langservers-extracted
  fish-lsp
)
