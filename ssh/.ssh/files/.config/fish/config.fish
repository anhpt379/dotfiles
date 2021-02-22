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

alias pp 'command sudo puppet agent -t'
alias ppa 'command sudo puppet agent -t --environment=$USER'

alias jc='sudo journalctl'
alias sc='sudo systemctl'

alias tmux 'command tmux attach -t $USER; or command tmux new -s $USER'

alias pbcopy 'nc 127.0.0.1 2224 --send-only'
alias pbpaste 'nc 127.0.0.1 2225 --recv-only'

alias root 'sudo -E -s fish'
alias sudo 'sudo -E'

# Fix nvim `Cannot open undo file for writing` sometimes
mkdir -p ~/.config/nvim/undo/
if [ (find . \! -user $USER -print 2>/dev/null | wc -l) -gt 0 ]
    sudo chown -R $USER ~/.config/nvim/undo/
end

# Shorten title
title (hostname | awk -F. '{ print $1 }')

# Fix <C-c> doesn't work in remote fish
bind \cc 'commandline ""'

# Fix git-deploy umask complaining
umask 0002

# Auto start tmux
if not set -q TMUX
    tmux
end
