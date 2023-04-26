abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'
abbr --add .... 'cd ../../..'
abbr --add ..... 'cd ../../../..'

abbr --add g 'git'
abbr --add gs 'git status'
abbr --add gco 'git checkout'

abbr --add b brew
abbr --add c clear
abbr --add f fzf
abbr --add h tldr
abbr --add ipy ipython
abbr --add j z
abbr --add l less
abbr --add l ll
abbr --add m master
abbr --add o openstack
abbr --add p python
abbr --add q exit
abbr --add t tail
abbr --add tf tail -f
abbr --add v nvimpager

abbr --add vim nvim
abbr --add nv nvim

if not string match -e -q -- fedora (hostname)
    abbr --add ppcatalog 'sudo cat "/opt/puppetlabs/puppet/cache/client_data/catalog/$(sudo puppet config print certname).json" | jq | less'

    abbr --add k 'kubectl'
    abbr --add kd 'kubectl describe'
    abbr --add kdf 'kubectl delete --force --grace-period=0'
    abbr --add kn 'kubectl config set-context --current --namespace'
end

# grc fish integration
if [ -f ~/.cargo/bin/grc-rs ]
    alias grcat 'grc-rs --colour=on cat'

    for cmd in df id ip w uptime stat
        type "$cmd" >/dev/null 2>&1 && alias "$cmd"="grc-rs --colour=auto $cmd"
    end
else
    alias grcat 'grcat conf.cat'
end

abbr --add cmd 'command'
abbr --add root 'sudo -E -s fish'

abbr --add ncdu 'ncdu -rr -x --exclude .git'
abbr --add fd 'command fd --one-file-system --hidden --exclude=".git"'

abbr --add pwl 'nvim ~/.config/nvim/dictionaries/personal_word_list.txt'

abbr --add docker 'sudo -E docker'
abbr --add docker-compose 'sudo -E docker-compose'

abbr --add http xh
abbr --add https xhs


# if command -v prettyping &>/dev/null
#     abbr --add ping "prettyping --nolegend"
# else if command -v hping3 &>/dev/null
#     abbr --add ping hping3
# end
