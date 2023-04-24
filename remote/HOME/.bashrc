#!/bin/bash

# Fix unreadable dir names with 777 permissions
# https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission
export LS_COLORS=":ow=:"

# Add ~/.local/bin to $PATH
export PATH=$HOME/.local/bin:$PATH

# Fix SSH auth socket location so agent forwarding works within tmux
if [[ -n $SSH_CONNECTION ]]; then
  mkdir -p ~/.ssh

  if [[ -n $SSH_AUTH_SOCK ]] && [[ $SSH_AUTH_SOCK != */.ssh/ssh_auth_sock ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi

  if [[ -n $SSH_TTY ]] && [[ $SSH_TTY != */.ssh/ssh_tty ]]; then
    ln -sf "$SSH_TTY" ~/.ssh/ssh_tty
  fi
fi

# A nicer bash prompt
if [ "$(id -u)" -eq 0 ]; then
  PS1="\[\e[00;31m\][\h \w]# \[\e[00m\]"
else
  PS1="[\h \w]$ "
fi

# Load aliases
source ~/.bash_aliases

# Fix `sudo lla` doesn't work in bash
alias sudo='sudo -E TERM=xterm-256color '

# Reset cursor shape to beam
PS1+="$(printf '\033[6 q')"

# Fix git-deploy umask complaining
umask 0002

# Extract nvim appimage
if ! test -f ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim || test ~/.local/bin/nvim.appimage -nt ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim; then
  if test -f ~/.local/bin/nvim.appimage; then
    rm -rf ~/.local/bin/nvim-appimage/
    mkdir -p ~/.local/bin/nvim-appimage/
    cd ~/.local/bin/nvim-appimage/ || exit 1
    ../nvim.appimage --appimage-extract >/dev/null
  fi
fi

cd ~/ || exit 1
