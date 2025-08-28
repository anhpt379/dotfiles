#!/bin/bash

# Fix `sudo lla` doesn't work in bash
alias sudo='sudo -E '

# Some commonly used aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias g='git'
alias gs='git status'
alias gco='git checkout'

alias ls='ls --color=yes --group-directories-first -vF'
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

alias py='python'
alias ipy='ipython'

alias d='docker'
alias dc='docker compose'

if test "$(whoami)" = 'root'; then
  alias start='systemctl start'
  alias stop='systemctl stop'
  alias restart='systemctl restart'
  alias status='systemctl status'

  alias pp='puppet agent -t'
  alias ppf='killall puppet 2>/dev/null; pp --enable; pp'
  alias ppa='puppet agent -t --environment=panh'
  alias ppaf='killall puppet 2>/dev/null; pp --enable; ppa'
  alias ppcatalog='cat "/opt/puppetlabs/puppet/cache/client_data/catalog/$(puppet config print certname).json" | jq . | less'
else
  alias start='sudo systemctl start'
  alias stop='sudo systemctl stop'
  alias restart='sudo systemctl restart'
  alias status='sudo systemctl status'

  alias pp='command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t'
  alias ppf='sudo killall puppet 2>/dev/null; pp --enable; pp'
  alias ppa='command sudo HOME=/root TERMINFO=/home/panh/.terminfo puppet agent -t --environment=panh'
  alias ppaf='sudo killall puppet 2>/dev/null; pp --enable; ppa'
  alias ppcatalog='sudo cat "/opt/puppetlabs/puppet/cache/client_data/catalog/$(sudo puppet config print certname).json" | jq . | less'
fi
alias ppl='less /var/log/puppet/puppetagent.log'
alias ppc='cat /etc/puppetlabs/puppet/puppet.conf'
alias motd='cat /etc/motd; [ -f /etc/motd.local ] && cat /etc/motd.local'

alias cmd='command'

alias root='sudo -E -s'
alias r='sudo -E -s'

alias view='less'

alias whatprovides='repoquery -q --installed --whatprovides'
alias whatrequires='repoquery -q --installed --whatrequires'

alias ansible='TERM=xterm-256color command ansible'
alias ansible-playbook='TERM=xterm-256color command ansible-playbook'
