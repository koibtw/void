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
export XDG_DOCUMENTS_DIR="$HOME/docs"
export XDG_DOWNLOAD_DIR="$HOME/down"
export XDG_PICTURES_DIR="$HOME/pics"
export XDG_PROJECTS_DIR="$HOME/dev"
export XDG_VIDEOS_DIR="$HOME/vido"
export XDG_MUSIC_DIR='/media/music'
export XDG_PUBLICSHARE_DIR='/tmp/garbage'
export XDG_TEMPLATES_DIR='/tmp/garbage'

export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"

export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME/npm/config/npm-init.js"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR/npm"

export GRIM_DEFAULT_DIR="$XDG_PICTURES_DIR/screenshots"
[[ -d "$GRIM_DEFAULT_DIR" ]] || mkdir -p "$GRIM_DEFAULT_DIR"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export CARGO_TARGET_DIR="$XDG_CACHE_HOME/cargo"

if [[ -f "$CARGO_HOME/env" ]]; then
  source "$CARGO_HOME/env"
fi

if [[ -z "$WAYLAND_DISLPAY" ]] && [[ "$XDG_VTNR" = 1 ]]; then
  exec dbus-run-session mango
fi
