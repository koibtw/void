#!/usr/bin/env bash

set -euo pipefail

# util ==========================================================================================

SETUP="$(dirname "$0")"
ROOT="$(readlink -f "$(basename "$SETUP")/..")"
# shellcheck source=setup/util.sh
source "$SETUP/util.sh"
# shellcheck source=setup/packages.sh
source "$SETUP/packages.sh"

# doas ==========================================================================================

setup_doas() {
  sudo xbps-install -y opendoas
  echo 'permit persist :wheel' |
    sudo tee /etc/doas.conf >/dev/null
  doas xbps-remove -Ry sudo
}

# xbps ==========================================================================================

setup_xbps() {
  local file='00-vup.conf' arch tmp

  arch="$(xbps-uhelper arch)"
  tmp="$(temp 'xbps' "$file")"

  for repo in 'browsers' 'language-servers'; do
    local url="https://github.com/VUP-Linux/vup/releases/download/$repo-$arch-current"
    echo "repository=$url" >>"$tmp"
  done

  move_root "$tmp" "/etc/xbps.d/$file"
  rm -f "$tmp"
}

# etc ===========================================================================================

setup_etc() {
  find etc -type f -printf "%P\0" | while IFS= read -r -d '' file; do
    link_root "$(p_etc_src "$file")" "$(p_etc_dst "$file")"
  done
}

# pipewire ======================================================================================

setup_pipewire() {
  for file in 'wireplumber/10-wireplumber.conf' 'pipewire/20-pipewire-pulse.conf'; do
    link_root "/usr/share/examples/$file" "/etc/pipewire/pipewire.conf.d/$(basename "$file")"
  done
}

# tailscale =====================================================================================

setup_tailscale() {
  doas tailscale set --operator=koi
}

# rust ==========================================================================================

setup_rust() {
  RUSTUP_HOME="$XDG_DATA_HOME/rustup" \
    rustup-init --no-modify-path -y \
    -c rust-analyzer
}

# scripts =======================================================================================

install_scripts() {
  for file in "$ROOT/scripts/"*; do
    link_root "$file" "$(p_bin_dst "$(basename "$file")")"
  done
}

# themes ========================================================================================

install_themes() {
  local url='https://github.com/lassekongo83/adw-gtk3/releases/download/v6.5/adw-gtk3v6.5.tar.xz'
  local dir='/usr/share/themes/'
  local tmp

  tmp="$(temp 'themes' "$(basename "$url")")"
  download "$tmp" "$url"

  doas mkdir -p "$dir"
  doas tar -Jxf "$tmp" -C "$dir"
}

# shell =========================================================================================

setup_fish() {
  install_packages "${FISH_PACKAGES[@]}"
  doas chsh "$USER" -s /bin/fish

  download_config 'fish/themes/evergarden-fall.theme' \
    'https://codeberg.org/evergarden/fish/raw/themes/evergarden-fall.theme'
}

setup_zsh() {
  local tmp_rc

  install_packages "${ZSH_PACKAGES[@]}"
  doas chsh "$USER" -s /bin/zsh

  tmp_rc="$(temp 'zsh' 'rc')"
  for file in options keymap prompt aliases functions completions plugins init; do
    echo "source '$(p_zsh_src "$file")'" >>"$tmp_rc"
  done

  move "$tmp_rc" "$HOME/.zshrc"
  link "$(p_zsh_src profile)" "$HOME/.zprofile"
}

# home ==========================================================================================

setup_home() {
  # shellcheck disable=SC2174
  mkdir -pm 700 "$HOME/.vault"
}

# gtk ===========================================================================================

setup_gtk() {
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

  download_config 'gtk-3.0/gtk.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/evergarden-fall-green.css'
  download_config 'gtk-4.0/gtk.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/gtk4.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/evergarden-fall-green.css'
}

# config ========================================================================================

setup_config() {
  find config -type f -printf "%P\0" | while IFS= read -r -d '' file; do
    link "$(p_config_src "$file")" "$(p_config_dst "$file")"
  done

  download_config 'foot/evergarden-fall.ini' \
    'https://codeberg.org/evergarden/foot/raw/themes/evergarden-fall-green.ini'
  download_config 'halloy/themes/evergarden-fall.toml' \
    'https://codeberg.org/evergarden/halloy/raw/themes/evergarden-fall.toml'
}

# services ======================================================================================

setup_services() {
  enable_services chronyd tailscaled
}

# args ==========================================================================================

args() {
  local cmd="$1"

  if [[ -z "$cmd" ]]; then
    return
  fi

  for func in $(declare -F | cut -d' ' -f3); do
    if [[ "$func" = "setup_$cmd" ]]; then
      "$func"
      exit 0
    fi
  done

  if [[ -z "$found" ]]; then
    echo "$cmd is not defined"
    exit 1
  fi
}

# main ==========================================================================================

main() {
  args "${1:-}"

  [[ "$(command -v doas)" ]] || setup_doas
  setup_xbps

  install_packages "${PACKAGES[@]}"
  setup_services

  setup_etc
  setup_pipewire
  setup_tailscale 
  setup_rust

  install_packages "${LSP_PACKAGES[@]}"
  install_packages "${SHELL_PACKAGES[@]}"
  install_npm_packages "${NPM_PACKAGES[@]}"

  install_scripts
  install_themes

  setup_fish
  setup_home
  setup_gtk
  setup_config
}

main "$@"
