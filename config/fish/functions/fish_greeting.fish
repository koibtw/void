function fish_greeting
  and set_color $fish_color_comment
  test -f /etc/motd
  and cat /etc/motd
  and set_color $fish_color_normal

  set -l path "$XDG_DOCUMENTS_DIR/todo.md"
  test -f "$path"
  and set_color $fish_color_operator
  and glow "$path"
  and set_color $fish_color_normal
end
