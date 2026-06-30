#!/usr/bin/env bash

set -euo pipefail

# paths =========================================================================================

p_src() {
  local target="$1"
  echo "$ROOT/config/$target"
}

p_dst() {
  local target="$1"
  echo "$XDG_CONFIG_HOME/$target"
}

p_bin() {
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

link() {
  local target="$1"
  local src dst dir

  src="$(p_src "$target")"
  dst="$(p_dst "$target")"
  dir="$(dirname "$dst")"

  mkdir -p "$dir"
  backup "$src" "$dst"
  ln -sfn "$src" "$dst"
}

download() {
  local target="$1"
  local url="$2"
  local dst dir tmp

  dst="$(p_dst "$target")"
  dir="$(dirname "$dst")"
  tmp="$(temp "$dst" "$dir")"

  mkdir -p "$dir"
  curl -fsSL "$url" -o "$tmp"

  for add in "${@:3}"; do
    curl -fsSL "$add" >> "$tmp"
  done

  backup "$tmp" "$dst"
  mv "$tmp" "$dst"
}
