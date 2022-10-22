# grc fish integration
if [ -f ~/.cargo/bin/grc-rs ]
    alias grcat 'grc-rs --colour=on cat'

    for cmd in df id ip w uptime stat
        type "$cmd" >/dev/null 2>&1 && alias "$cmd"="grc-rs --colour=auto $cmd"
    end
else
    alias grcat 'grcat conf.cat'
end

if command -v exa >/dev/null
    alias ls 'exa --group-directories-first -F'
    alias la 'exa --group-directories-first -F -a'
    alias ll 'exa --group-directories-first -F -l'
    alias lla 'exa --group-directories-first -F -la'
end

alias root 'sudo -E -s fish'
alias cat less

alias ncdu 'ncdu -rr -x --exclude .git'
alias fd 'command fd --one-file-system --hidden --exclude=".git"'
alias view 'nvimpager -p'
alias man 'MANPAGER="nvimpager -p" command man'

alias pwl 'nvim ~/.config/nvim/dictionaries/personal_word_list.txt'

alias docker 'sudo -E docker'
alias docker-compose 'sudo -E docker-compose'

alias http xh
alias https xhs

alias j z
alias b brew
alias f fzf
alias h tldr
alias l ll
alias m master
alias o openstack

alias vim nvim

alias nf 'nvim +"FilesMru"'
alias ngs 'nvim +"tab Git"'
alias ngl 'nvim +"FzfCommits"'
alias nlf 'nvim +"Lf"'
alias nv 'nvim $argv'

alias ppl 'nvimpager -- --cmd "autocmd VimEnter * :normal G" /var/log/puppet/puppetagent.log'
alias ppc 'nvimpager -c -- --cmd "set ft=cfg" /etc/puppetlabs/puppet/puppet.conf'

if set -q TMUX
    alias clear 'tput reset'
end

if command -v prettyping &>/dev/null
    alias ping "prettyping --nolegend"
else if command -v hping3 &>/dev/null
    alias ping hping3
end
