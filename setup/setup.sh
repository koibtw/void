#!/usr/bin/env bash

set -euo pipefail

# helpers =======================================================================================

SETUP="$(dirname "$0")"
ROOT="$(readlink -f "$(basename "$SETUP")/..")"
source "$SETUP/helpers.sh"
source "$SETUP/packages.sh"

# doas ==========================================================================================

setup_doas() {
  sudo xbps-install -y opendoas
  echo 'permit persist :wheel' \
    | sudo tee /etc/doas.conf >/dev/null
  echo 'ignorepkg=sudo' \
    | sudo tee -a '/etc/xbps.d/10-ignore.conf' >/dev/null
  doas true
  doas xbps-remove -Ry sudo
}

# pipewire ======================================================================================

setup_pipewire() {
  doas xbps-install -y pipewire wireplumber
  doas ln -sfn /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
  doas ln -sfn /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/
}

# packages ======================================================================================

install_packages() {
  doas xbps-install -y "${PACKAGES[@]}"
}

# scripts =======================================================================================

install_scripts() {
  for file in "$ROOT/scripts/"*; do
    local name bin

    name="$(basename "$file")"
    bin="$(p_bin "$name")"

    [[ -f "$bin" ]] || continue

    backup "$file" "$bin"
    doas ln -sfn "$file" "$bin"
  done
}

# config ========================================================================================

install_config() {
  link 'fd/ignore'

  link 'foot/foot.ini'
  download 'foot/evergarden-fall.ini' \
    'https://codeberg.org/evergarden/foot/raw/themes/evergarden-fall-green.ini'

  link 'git/config'

  # TODO: adw-gtk3
  download 'gtk-3.0/gtk.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/evergarden-fall-green.css'
  download 'gtk-4.0/gtk.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/gtk4.css' \
    'https://codeberg.org/evergarden/adwaita/raw/themes/evergarden-fall-green.css'

  link 'jj/config.toml'

  link 'mango/config.conf'
}

# main ==========================================================================================

main() {
  [[ "$(command -v doas)" ]] || setup_doas
  setup_pipewire

  install_packages
  install_scripts
  install_config
}

main
