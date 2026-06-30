#!/usr/bin/env bash

set -euo pipefail

# paths =========================================================================================

p_config_src() {
  local target="$1"
  echo "$ROOT/config/$target"
}

p_config_dst() {
  local target="$1"
  echo "$XDG_CONFIG_HOME/$target"
}

p_bin_dst() {
  local target="$1"
  echo "/usr/local/bin/$target"
}

# files =========================================================================================

temp() {
  local dst="$1"
  local dir="$2"

  mktemp -p /tmp "setup.$(basename "$dir").$(basename "$dst").XXXXX"
}

backup() {
  local src="$1"
  local dst="$2"

  [[ ! -e "$dst" ]] && return
  cmp -s "$src" "$dst" || mv "$dst" "$dst.bak"
}

backup_root() {
  local src="$1"
  local dst="$2"

  [[ ! -e "$dst" ]] && return
  cmp -s "$src" "$dst" || doas mv "$dst" "$dst.bak"
}

link() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"
  backup "$src" "$dst"
  ln -sfn "$src" "$dst"
}

link_root() {
  local src="$1"
  local dst="$2"

  doas mkdir -p "$(dirname "$dst")"
  backup_root "$src" "$dst"
  doas ln -sfn "$src" "$dst"
}

download_config() {
  local target="$1"
  local url="$2"
  local dst dir tmp

  dst="$(p_config_dst "$target")"
  dir="$(dirname "$dst")"
  tmp="$(temp "$dst" "$dir")"

  mkdir -p "$dir"
  curl -fsSL "$url" -o "$tmp"

  for add in "${@:3}"; do
    curl -fsSL "$add" >>"$tmp"
  done

  backup "$tmp" "$dst"
  mv "$tmp" "$dst"
}

# packages ======================================================================================

install_packages() {
  doas xbps-install -y "$@"
}

install_npm_packages() {
  doas npm i -g "$@"
}
