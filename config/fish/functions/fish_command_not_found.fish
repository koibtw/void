function fish_command_not_found
  echo -e "command \e[91m$argv\e[0m not found!! \e[91mSTUPID! BONK!\e[0m :3"
  return 127
end
