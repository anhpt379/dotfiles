#!/bin/bash

# Fix blue dircolor is too dark
export LS_COLORS=

# Fix SSH auth socket location so agent forwarding works within tmux
if [[ -n $SSH_CONNECTION ]]; then
  if [[ -n "$SSH_AUTH_SOCK" ]] && [[ "$SSH_AUTH_SOCK" != */.ssh/ssh_auth_sock ]]; then
    mkdir -p ~/.ssh
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  fi
fi

# A nicer bash prompt
if [ "$(id -u)" -eq 0 ]; then
  PS1="\[\e[01;31m\][\u@\h \w]# \[\e[00m\]"
else
  PS1="[\u@\h \w]$ "
fi

# Some commonly used aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls='ls --color=yes -U'
alias la='ls --color=yes -Ua'
alias ll='ls --color=yes -Ulh'
alias lla='ls --color=yes -UlhA'

alias g='git'
alias gs='git status'
alias pp='command sudo -E puppet agent -t'
alias ppa='command sudo -E puppet agent -t --environment=$(whoami)'

alias pbcopy='nc 127.0.0.1 2224 --send-only'
alias pbpaste='nc 127.0.0.1 2225 --recv-only'

alias root='sudo -E -s'
alias sudo='sudo -E'
