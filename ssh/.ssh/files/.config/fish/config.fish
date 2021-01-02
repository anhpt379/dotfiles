#!/usr/bin/env fish

set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.local/bin/nvim/squashfs-root/usr/bin $PATH

if not test -e ~/.local/bin/nvim/squashfs-root/usr/bin/nvim
  cd ~/.local/bin/
  mkdir -p nvim
  cd nvim
  ../nvim.appimage --appimage-extract
  cd ~
end

source ~/.config/omf/init.fish

alias pp  'command sudo puppet agent -t'
alias ppa 'command sudo puppet agent -t --environment=panh'

alias t 'tmux attach -t panh; or tmux new -s panh'

alias pbcopy  'nc 127.0.0.1 2224 --send-only'
alias pbpaste 'nc 127.0.0.1 2225 --recv-only'

alias root 'sudo -s -E'
alias sudo 'sudo -E'

# Shorten title
title (hostname | awk -F. '{ print $1 }')
