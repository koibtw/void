function fish_aliases -d 'set custom shell aliases'
  alias vi nvim

  alias car cat
  alias shred 'shred -uvz'
  
  alias diff 'diff --color=auto'
  alias grep 'grep --color=auto'
  alias ip 'ip -color=auto'

  # double quoting for multiline
  alias ls "eza --no-quotes --group-directories-last --icons=auto --git --group \
    --color-scale=all --color-scale-mode=fixed"

  alias ll 'ls -l'
  alias ld 'ls -d'
  alias la 'ls -la'
  alias lA 'ls -lA'
end
