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
alias ppa 'command sudo puppet agent -t --environment=$BOOKING_USER'
alias ppl 'view /var/log/puppet/puppetagent.log'

alias tmux 'command tmux attach -t $BOOKING_USER; or command tmux new -s $BOOKING_USER'

alias pbcopy 'nc 127.0.0.1 2224 --send-only'
alias pbpaste 'nc 127.0.0.1 2225 --recv-only'

alias root 'sudo -E -s fish'
alias sudo 'sudo -E'

alias vim 'nvim'

# Systemctl aliases
alias sc='sudo systemctl'
alias jc='sudo journalctl'
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias restart="sudo systemctl restart"
alias info="sudo systemctl status"
function log
    if [ (count $argv) -eq 1 ]
        sudo journalctl --no-pager --lines=1000 -u $argv | view
    else
        sudo journalctl --no-pager --lines=$argv[2] -u $argv[1] | view
    end
end

# Fix nvim `Cannot open undo file for writing` sometimes
mkdir -p ~/.config/nvim/undo/
if [ (find . \! -mount -type f -user $BOOKING_USER -print 2>/dev/null | wc -l) -gt 0 ]
    sudo chown -R $BOOKING_USER ~/.config/nvim/undo/
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
