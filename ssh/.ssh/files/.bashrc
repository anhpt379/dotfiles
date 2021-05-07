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

alias g='git'
alias gs='git status'
alias push='git push origin'
alias fetch='git fetch origin'
alias reset='git reset'
alias freset='git fetch origin; git reset --hard'
alias rebase='git rebase'
alias master='git checkout master; git diff-index --quiet HEAD && git pull --rebase origin master'
alias gadd='git add'
alias gpush='git push'
alias gpull='git pull'
alias gfetch='git fetch'
alias gco='git checkout'
alias glog='git log'
alias greset='git reset'
alias grevert='git revert'
alias grestore='git restore'
alias grebase='git rebase'
alias gdiff='git diff'
alias gshow='git show'
alias gstash='git stash'
alias gclone='git clone'
alias gremote='git remote'
alias gbranch='git branch'

alias ls='ls --color=yes --group-directories-first'
alias la='command ls --color=yes --group-directories-first -A'
alias ll='command ls --color=yes --group-directories-first -lh'
alias lla='command ls --color=yes --group-directories-first -lhA'

alias c='clear'
alias m='master'

alias sc='sudo systemctl'
alias jc='sudo journalctl'
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias restart="sudo systemctl restart"
alias info="sudo systemctl status"
alias log="sudo journalctl --lines=10000 -u"

alias pp='command sudo puppet agent -t'
alias ppa='command sudo puppet agent -t --environment=$BOOKING_USER'
alias ppl='view /var/log/puppet/puppetagent.log'
alias cmd='command'

alias pbcopy='nc 127.0.0.1 2224 --send-only'
alias pbpaste='nc 127.0.0.1 2225 --recv-only'

alias root='sudo -E -s'
alias sudo='sudo -E'

alias view='vim'

# Fix git-deploy umask complaining
umask 0002
