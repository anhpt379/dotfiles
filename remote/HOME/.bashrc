#!/bin/bash

source ~/.bash_aliases

# Fix unreadable dir names with 777 permissions
# https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission
export LS_COLORS=":ow=:"

# Fix unable to find `nginx` command
export PATH=/usr/sbin:$PATH

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

# Reset cursor shape to beam
PROMPT_COMMAND="printf '\033[6 q'"

# Fix git-deploy umask complaining
umask 0002

# Extract tmux appimage
if ! test -f ~/.local/bin/tmux-appimage/squashfs-root/usr/bin/tmux || test ~/.local/bin/tmux.appimage -nt ~/.local/bin/tmux-appimage/squashfs-root/usr/bin/tmux || ! test -e ~/.local/bin/tmux; then
  if test -f ~/.local/bin/tmux.appimage; then
    rm -rf ~/.local/bin/tmux-appimage/
    mkdir -p ~/.local/bin/tmux-appimage/
    cd ~/.local/bin/tmux-appimage/ || exit 1
    ../tmux.appimage --appimage-extract >/dev/null

    ln -sf ~/.local/bin/tmux-appimage/squashfs-root/usr/bin/tmux ~/.local/bin/tmux
  fi
fi

# Extract nvim appimage
if ! test -f ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim || test ~/.local/bin/nvim.appimage -nt ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim || ! test -e ~/.local/bin/nvim; then
  if test -f ~/.local/bin/nvim.appimage; then
    rm -rf ~/.local/bin/nvim-appimage/
    mkdir -p ~/.local/bin/nvim-appimage/
    cd ~/.local/bin/nvim-appimage/ || exit 1
    ../nvim.appimage --appimage-extract >/dev/null

    ln -sf ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim ~/.local/bin/nvim
  fi
fi

cd ~/ || exit 1
