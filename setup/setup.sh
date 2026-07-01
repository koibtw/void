#!/usr/bin/env bash

set -euo pipefail

# helpers =======================================================================================

SETUP="$(dirname "$0")"
ROOT="$(readlink -f "$(basename "$SETUP")/..")"
# shellcheck source=setup/helpers.sh
source "$SETUP/helpers.sh"
# shellcheck source=setup/packages.sh
source "$SETUP/packages.sh"

# doas ==========================================================================================

setup_doas() {
  sudo xbps-install -y opendoas
  echo 'permit persist :wheel' |
    sudo tee /etc/doas.conf >/dev/null
  echo 'ignorepkg=sudo' |
    sudo tee -a '/etc/xbps.d/10-ignore.conf' >/dev/null
  doas true
  doas xbps-remove -Ry sudo
}

# pipewire ======================================================================================

setup_pipewire() {
  install_packages pipewire wireplumber
  for file in 'wireplumber/10-wireplumber.conf' 'pipewire/20-pipewire-pulse.conf'; do
    link_root "/usr/share/examples/$file" "/etc/pipewire/pipewire.conf.d/$(basename "$file")"
  done
}

# rust ==========================================================================================

setup_rust() {
  install_packages rustup
  rustup-init --no-modify-path -y \
    -c rust-analyzer
}

# scripts =======================================================================================

install_scripts() {
  for file in "$ROOT/scripts/"*; do
    link_root "$file" "$(p_bin_dst "$(basename "$file")")"
  done
}

# zsh ===========================================================================================

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

# config ========================================================================================

install_config() {
  find config -type f -printf "%P\0" | while IFS= read -r -d '' file; do
    link "$(p_config_src "$file")" "$(p_config_dst "$file")"
  done

  download_config 'foot/evergarden-fall.ini' \
    'https://codeberg.org/evergarden/foot/raw/themes/evergarden-fall-green.ini'

  # TODO: adw-gtk3
  download_config 'gtk-3.0/gtk.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/evergarden-fall-green.css'
  download_config 'gtk-4.0/gtk.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/gtk4.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/evergarden-fall-green.css'
}

# main ==========================================================================================

main() {
  [[ "$(command -v doas)" ]] || setup_doas
  setup_pipewire

  setup_rust

  install_packages "${PACKAGES[@]}"
  install_packages "${LSP_PACKAGES[@]}"
  install_npm_packages "${NPM_PACKAGES[@]}"

  install_scripts

  setup_zsh
  install_config
}

main
