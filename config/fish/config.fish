if status is-interactive
  fish_config theme choose evergarden-fall

  set -gx GPG_TTY (tty)
  zoxide init fish | source
end
