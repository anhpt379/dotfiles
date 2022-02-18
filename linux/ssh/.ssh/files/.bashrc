#!/bin/bash

# Fix blue dircolor is too dark
export LS_COLORS=

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
alias rebase='git rebase'
reset() {
  if ! git cat-file -e "$1" 2> /dev/null; then
    git fetch origin
  fi
  git reset --hard "$1"
}
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

alias dmesg='dmesg -H'

alias q='exit'
alias c='clear'
alias m='master'
alias l='less'
alias t='tail'
alias tf='tail -f'

alias sc='sudo systemctl'
alias jc='sudo journalctl'
alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias info='sudo systemctl status'
alias log='sudo journalctl -e -u'

alias pp='command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t'
alias ppa='command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t --environment=$BOOKING_USER'
alias ppl='less +G /var/log/puppet/puppetagent.log'
alias ppc='cat /etc/puppetlabs/puppet/puppet.conf'

alias cmd='command'

alias pbcopy='nc 127.0.0.1 2224 --send-only'
alias pbpaste='nc 127.0.0.1 2225 --recv-only'

alias root='sudo -E -s'
alias sudo='sudo -E'

alias view='vim'

# Fix git-deploy umask complaining
umask 0002

# Extract nvim appimage
if [ ! -f ~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim ]; then
  if [ -d ~/.local/bin/nvim ]; then
    rm -rf ~/.local/bin/nvim
  fi

  if [ -f ~/.local/bin/nvim.appimage ]; then
    mkdir -p ~/.local/bin/nvim-appimage/
    cd ~/.local/bin/nvim-appimage/ || exit 1
    ../nvim.appimage --appimage-extract
    ln -sf ~/.local/bin/nvim-appimage/squashfs-root/AppRun ~/.local/bin/nvim
  fi
fi

cd ~/ || exit 1
