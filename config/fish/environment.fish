set -gx EDITOR 'nvim'
set -gx MANPAGER 'nvim +Man!'

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"

set -gx XDG_DESKTOP_DIR "$HOME/desk"
set -gx XDG_DOCUMENTS_DIR "$HOME/text"
set -gx XDG_DOWNLOAD_DIR "$HOME/down"
set -gx XDG_PICTURES_DIR "$HOME/pics"
set -gx XDG_PROJECTS_DIR "$HOME/dev"
set -gx XDG_VIDEOS_DIR "$HOME/vido"
set -gx XDG_MUSIC_DIR '/media/data/music'
set -gx XDG_PUBLICSHARE_DIR '/dev/null'
set -gx XDG_TEMPLATES_DIR '/dev/null'

set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -gx INPUTRC "$XDG_CONFIG_HOME/readline/inputrc"

set -gx GRIM_DEFAULT_DIR "$XDG_PICTURES_DIR/screenshots"

set -gx NPM_CONFIG_INIT_MODULE "$XDG_CONFIG_HOME/npm/config/npm-init.js"
set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -gx NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"

set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx CARGO_TARGET_DIR "$XDG_CACHE_HOME/cargo"
