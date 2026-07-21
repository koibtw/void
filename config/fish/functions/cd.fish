function cd -w cd -d 'custom zoxide wrapper'
  if test (count $argv) -eq 0
    builtin cd
    and ls
    return
  end

  if test -d "$argv[1]"
    builtin cd $argv
    and ls
    return
  end

  set -l res (command zoxide query --exclude (__zoxide_pwd) -- $argv 2>/dev/null)

  if test $status -ne 0
    echo -e "dir \e[91m$argv\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
    return $status
  end

  builtin cd "$res"
  and ls
end
