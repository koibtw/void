#!/usr/bin/env bash

set -euo pipefail

# paths =========================================================================================

p_zsh_src() {
  local target="$1"
  echo "$ROOT/zsh/$target.zsh"
}

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
  local dir="$1"
  local dst="$2"

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

move() {
  local tmp="$1"
  local dst="$2"

  backup "$tmp" "$dst"
  mv "$tmp" "$dst"
}

move_root() {
  local tmp="$1"
  local dst="$2"

  backup_root "$tmp" "$dst"
  doas mv "$tmp" "$dst"
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

download() {
  local target="$1"
  local url="$2"

  curl -fsSL "$url" -o "$target"

  for add in "${@:3}"; do
    curl -fsSL "$add" >>"$target"
  done
}

download_config() {
  local target="$1"
  local url="$2"
  local dst dir tmp

  dst="$(p_config_dst "$target")"
  dir="$(dirname "$dst")"
  tmp="$(temp "$dir" "$dst")"

  mkdir -p "$dir"
  download "$tmp" "$url" "${@:3}"

  move "$tmp" "$dst"
}

# packages ======================================================================================

install_packages() {
  doas xbps-install -y "$@"
}

install_npm_packages() {
  NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm" \
    doas npm i -g "$@"
}
