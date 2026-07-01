function doas() {
  command doas "$@"
}

function ls() {
  eza --no-quotes --group-directories-last --icons=auto --git --group \
    --color-scale=all --color-scale-mode=fixed "$@"
}

function cd() {
  { z "$@" 2>/dev/null && ls; } || {
    echo "dir \e[91m$*\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
    return 1
  }
}

function command_not_found_handler() {
  echo "command \e[91m$1\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
  return 127
}
