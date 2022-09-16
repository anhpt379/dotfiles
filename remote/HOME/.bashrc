#!/bin/bash

# Fix unreadable dir names with 777 permissions
# https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission
export LS_COLORS=":ow=:"

# Add ~/.local/bin to $PATH
export PATH=$HOME/.local/bin:$PATH

# Fix SSH auth socket location so agent forwarding works within tmux
if [[ -n $SSH_CONNECTION ]]; then
  if [[ -n "$SSH_AUTH_SOCK" ]] && [[ "$SSH_AUTH_SOCK" != */.ssh/ssh_auth_sock ]]; then
    mkdir -p ~/.ssh
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi
fi

# A nicer bash prompt
if [ "$(id -u)" -eq 0 ]; then
  PS1="\[\e[01;31m\][\h \w]# \[\e[00m\]"
else
  PS1="[\h \w]$ "
fi

# Load aliases
source ~/.bash_aliases

# Fix git-deploy umask complaining
umask 0002

# Extract nvim appimage
if [ ! -f ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim ]; then
  if [ -f ~/.local/bin/nvim.appimage ]; then
    mkdir -p ~/.local/bin/nvim-appimage/
    cd ~/.local/bin/nvim-appimage/ || exit 1
    ../nvim.appimage --appimage-extract
  fi
fi

cd ~/ || exit 1
