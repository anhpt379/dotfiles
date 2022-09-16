#!/bin/bash

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

alias ls='command ls --color=yes --group-directories-first -vF'
alias la='command ls --color=yes --group-directories-first -vF -A'
alias ll='command ls --color=yes --group-directories-first -vF -lh'
alias lla='command ls --color=yes --group-directories-first -vF -lhA'

alias dmesg='dmesg --color'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias q='exit'
alias c='clear'
alias m='master'
alias l='less'
alias v='nvimpager'
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
alias ppf='killall puppet; pp --enable; pp'
alias ppa='command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t --environment=panh'
alias ppaf='killall puppet; pp --enable; ppa; pp --disable "panh ppaf" --for=4; date'
alias ppl='less +G /var/log/puppet/puppetagent.log'
alias ppc='cat /etc/puppetlabs/puppet/puppet.conf'
alias motd='cat /etc/motd; [ -f /etc/motd.local ] && cat /etc/motd.local'

alias cmd='command'

alias pbcopy='nc 127.0.0.1 2224 --send-only'
alias pbpaste='nc 127.0.0.1 2225 --recv-only'

alias root='sudo -E -s'
alias sudo='sudo -E TERM=xterm-256color'

alias view='less'

alias ansible='TERM=xterm-256color command ansible'
alias ansible-playbook='TERM=xterm-256color command ansible-playbook'

alias k='kubectl'
alias kd='kubectl describe'
alias kdf='kubectl delete --force --grace-period=0'
alias kn='kubectl config set-context --current --namespace'

alias urldecode='python3 -c "import sys, urllib.parse; print(urllib.parse.unquote_plus(sys.argv[1]))"'
alias urlencode='python3 -c "import sys, urllib.parse; print(urllib.parse.quote_plus(sys.argv[1]))"'

alias finder_show_hidden_files="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias finder_hide_hidden_files="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
alias finder_hide_desktop_files="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias finder_show_desktop_files="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
