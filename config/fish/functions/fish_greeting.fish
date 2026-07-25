function fish_greeting
  set -l path "$XDG_DOCUMENTS_DIR/todo.md"
  test -f "$path"
  and set_color $fish_color_operator
  and glow "$path"
  and set_color $fish_color_normal
end
