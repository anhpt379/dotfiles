# grc fish integration
if [ -f ~/.cargo/bin/grc-rs ]
    alias grc   'grc-rs'
    alias grcat 'grc-rs --colour=on cat'
    source /etc/grc.fish
else
    alias grcat 'grcat conf.cat'
end

alias ls  'exa --group-directories-first -F'
alias la  'exa --group-directories-first -F -a'
alias ll  'exa --group-directories-first -F -l'
alias lla 'exa --group-directories-first -F -la'

alias root 'sudo -E -s fish'
alias cat  'less'

alias ncdu 'ncdu -rr -x --exclude .git'
alias fd   'fd --hidden --exclude=".git"'
alias view 'nvimpager -p'
alias man 'MANPAGER="nvimpager -p" command man'

alias pwl 'nvim ~/.config/nvim/dictionaries/personal_word_list.txt'

alias docker         'sudo -E docker'
alias docker-compose 'sudo -E docker-compose'

alias http  'xh'
alias https 'xhs'

alias j 'z'
alias b 'brew'
alias f 'fzf'
alias h 'tldr'
alias l 'll'
alias m 'master'
alias o 'openstack'

alias vim 'nvim'

alias nf  'nvim +"FilesMru"'
alias ngs 'nvim +"tab Git"'
alias ngl 'nvim +"FzfCommits"'
alias nlf 'nvim +"Lf"'
alias nv  'nvim $argv'

alias ppl  'nvimpager -- --cmd "autocmd VimEnter * :normal G" /var/log/puppet/puppetagent.log'
alias ppc  'nvimpager -c -- --cmd "set ft=cfg" /etc/puppetlabs/puppet/puppet.conf'

if set -q TMUX
    alias clear 'tput reset'
end

function update
    fisher update
    omf update
    if command -v brew
        brew bundle
        brew bundle cleanup
        brew bundle cleanup --force
        brew outdated
        brew upgrade
    end
    if command -v tldr
        tldr --update
    end
end

function less
    if [ ! -t 1 ]
        command less --quit-if-one-screen $argv
        return
    end

    if [ (count $argv) -ge 1 ]
        set -f file $argv[-1]

        if [ -e "$file" ]
            set -f file_size (command ls -s --block-size=1048576 "$file" | cut -d' ' -f1) # in MB

            # Open big files, or files with one really long line with less
            if [ $file_size -gt 200 ] || [ "$(head --bytes=4096 "$file" 2>/dev/null | head -1 | wc --chars)" -gt 1000 ]
                command less --line-numbers $argv
                return
            end
        else
            echo "$file: No such file or directory"
            return 1
        end
    end

    nvimpager -a $argv
end
