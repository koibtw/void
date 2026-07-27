function fish_git_prompt
  command -sq git
  or return 1

  test -n "$(command git rev-parse --is-inside-work-tree 2>/dev/null)"
  or return

  set -l rev "$(command git rev-parse --short=8 HEAD 2>/dev/null)"
  test -n "$rev"
  or return

  set -l branch "$(command git rev-parse --abbrev-ref HEAD 2>/dev/null)"

  set -l sign ' '

  test -n "$(command git diff --name-status 2>/dev/null)"
  and set -l sign '!'

  test -n "$(command git diff --name-status --cached 2>/dev/null)"
  and set -l sign '@'

  printf '%b %s %b %b%s %b%s%b' \
    '\e[90m(\e[34m' "$rev" '\e[90m)\e[0m' '\e[33m' "$sign" '\e[35m' "$branch" '\e[0m'
end
