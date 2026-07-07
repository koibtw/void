export HISTFILE="$HOME/.histfile"
export HISTSIZE=10000
export SAVEHIST=10000

export EDITOR='nvim'
export MANPAGER='nvim +Man!'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_DESKTOP_DIR="$HOME/desk"
export XDG_DOCUMENTS_DIR="$HOME/doc"
export XDG_DOWNLOAD_DIR="$HOME/down"
export XDG_PICTURES_DIR="$HOME/pics"
export XDG_PROJECTS_DIR="$HOME/dev"
export XDG_VIDEOS_DIR="$HOME/vido"
export XDG_MUSIC_DIR='/media/music'
export XDG_PUBLICSHARE_DIR='/tmp/garbage'
export XDG_TEMPLATES_DIR='/tmp/garbage'

export GRIM_DEFAULT_DIR="$XDG_PICTURES_DIR/screenshots"
[[ -d "$GRIM_DEFAULT_DIR" ]] || mkdir -p "$GRIM_DEFAULT_DIR"

export CARGO_TARGET_DIR="$HOME/.cargo/target"
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

if [[ -z "$WAYLAND_DISLPAY" ]] && [[ "$XDG_VTNR" = 1 ]]; then
  exec dbus-run-session mango
fi
