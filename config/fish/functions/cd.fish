if not status is-interactive
  return
end

function cd -w __zoxide_cd -d 'custom zoxide wrapper'
  set -l argc (builtin count $argv)

  if test $argc -eq 0
    __zoxide_cd "$HOME"
    and ls
    return
  end

  if test -d "$argv[1]" -o "$argv[1]" = '-'
    __zoxide_cd "$argv[1]"
    and ls
    return
  end

  set -l path (command zoxide query --exclude (__zoxide_pwd) -- $argv 2>/dev/null)
  set -l res $status

  if test $res -ne 0
    echo -e "dir \e[91m$argv\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
    return $res
  end

  __zoxide_cd "$path"
  and ls
end
