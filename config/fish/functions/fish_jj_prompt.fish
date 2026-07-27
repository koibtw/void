function fish_jj_prompt
  command -sq jj
  or return 1

  set -l brb '\e[90m'
  set -l bor '\e[1;31m'
  set -l rey '\e[0;33m'
  set -l res '\e[39m'
  set -l template (printf 'concat(
    raw_escape_sequence("%s( "),
    truncate_end(8, change_id),
    raw_escape_sequence(" %s| "),
    truncate_end(8, commit_id),
    raw_escape_sequence(" %s)%s "),
    if(conflict, raw_escape_sequence("%sC"), " "),
    if(!empty, raw_escape_sequence(" %s!%s"), "  "),
    if(divergent, " D ", "   "),
    bookmarks
  )' "$brb" "$brb" "$brb" "$res" "$bor" "$rey" "$res")

  command jj log --color=always --no-graph -r @ -T "$template" 2>/dev/null
end
