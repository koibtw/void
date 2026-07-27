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

  set -l res (set_color $fish_color_normal)
  set -l brb (set_color $fish_color_autosuggestion)
  set -l dir (set_color $fish_color_dirty)
  printf '%b %s %s %s %b%s%s' \
    "$brb(\e[34m" "$rev" "$brb)" "$dir$sign" '\e[35m' "$branch" "$res"
end
