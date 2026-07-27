function fish_jj_prompt
  command -sq jj
  or return 1

  set -l res (set_color $fish_color_normal)
  set -l brb (set_color $fish_color_autosuggestion)
  set -l del (set_color $fish_color_hg_deleted)
  set -l dir (set_color $fish_color_hg_dirty)
  set -l unt (set_color $fish_color_hg_untracked)
  set -l template (printf 'concat(
    raw_escape_sequence("%s( "),
    truncate_end(8, change_id),
    raw_escape_sequence(" %s| "),
    truncate_end(8, commit_id),
    raw_escape_sequence(" %s)%s "),
    if(conflict, raw_escape_sequence("%sC%s"), " "),
    if(!empty, raw_escape_sequence(" %s!%s"), "  "),
    if(divergent, raw_escape_sequence(" %sD%s "), "   "),
    bookmarks
  )' "$brb" "$brb" "$brb" "$res" "$del" "$res" "$dir" "$res" "$unt" "$res")

  command jj log --color=always --no-graph -r @ -T "$template" 2>/dev/null
end
