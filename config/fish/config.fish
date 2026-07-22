set -gx GPG_TTY (tty)
set -l config (status dirname)

if status is-interactive
  fish_config theme choose evergarden-fall
  source "$config/aliases.fish"
  zoxide init fish --no-cmd | source
end

if status is-login
  source "$config/environment.fish"

  test -d "$GRIM_DEFAULT_DIR"
  or mkdir -p "$GRIM_DEFAULT_DIR"

  test -f "$CARGO_HOME/env.fish"
  and source "$CARGO_HOME/env.fish"

  test -z "$DISPLAY"
  and test "$XDG_VTNR" = 1
  and exec dbus-run-session mango
end
