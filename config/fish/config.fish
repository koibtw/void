if status is-interactive
  fish_config theme choose evergarden-fall
  fish_aliases

  set -gx GPG_TTY (tty)
  zoxide init fish | source
end

if status is-login
  set -gx EDITOR 'nvim'
  set -gx MANPAGER 'nvim +Man!'

  set -gx XDG_CONFIG_HOME "$HOME/.config"
  set -gx XDG_CACHE_HOME "$HOME/.cache"
  set -gx XDG_DATA_HOME "$HOME/.local/share"
  set -gx XDG_STATE_HOME "$HOME/.local/state"

  set -gx XDG_DESKTOP_DIR "$HOME/desk"
  set -gx XDG_DOCUMENTS_DIR "$HOME/docs"
  set -gx XDG_DOWNLOAD_DIR "$HOME/down"
  set -gx XDG_PICTURES_DIR "$HOME/pics"
  set -gx XDG_PROJECTS_DIR "$HOME/dev"
  set -gx XDG_VIDEOS_DIR "$HOME/vido"
  set -gx XDG_MUSIC_DIR '/media/music'
  set -gx XDG_PUBLICSHARE_DIR '/tmp/garbage'
  set -gx XDG_TEMPLATES_DIR '/tmp/garbage'

  set -gx GRIM_DEFAULT_DIR "$XDG_PICTURES_DIR/screenshots"
  test -d "$GRIM_DEFAULT_DIR" || mkdir -p "$GRIM_DEFAULT_DIR"

  set -gx CARGO_TARGET_DIR "$HOME/.cargo/target"
  
  test -f "$HOME/.cargo/env.fish"
  and source "$HOME/.cargo/env.fish"

  test -z "$DISLPAY"
  and test "$XDG_VTNR" -eq 1
  and exec dbus-run-session mango
end
