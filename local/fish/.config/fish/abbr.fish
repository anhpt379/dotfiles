abbr -a ..    'cd ..'
abbr -a ...   'cd ../..'
abbr -a ....  'cd ../../..'
abbr -a ..... 'cd ../../../..'

abbr -a g   'git'
if begin
        string match -e -q -- Darwin (uname)
        or string match -e -q -- fedora (hostname)
    end
    abbr -a gs 'git status'
else
    abbr -a gs 'git status --untracked-files=no'
end
abbr -a gco 'git checkout'
abbr -a m   'master'

abbr -a c 'clear'
abbr -a q 'exit'

abbr -a b 'brew'
abbr -a h 'tldr'

abbr -a o   'openstack'
abbr -a py  'python'
abbr -a ipy 'ipython'

abbr -a tf  'tail -f'

abbr -a v   'nvim'
abbr -a vim 'nvim'
abbr -a nv  'nvim'

abbr -a gpt 'gptree ./ && cat gptree_output.txt | pbcopy && rm -f gptree_output.txt .gptree_config'

abbr -a cmd  'command'
abbr -a r    'sudo -E -s fish'
abbr -a root 'sudo -E -s fish'

abbr -a start   'sudo systemctl start'
abbr -a stop    'sudo systemctl stop'
abbr -a restart 'sudo systemctl restart'
abbr -a status  'sudo systemctl status'

abbr -a fd   'command fd --one-file-system --hidden --exclude=".git"'
abbr -a ncdu 'ncdu -rr -x --exclude .git'

abbr -a http  'xh'
abbr -a https 'xhs'

abbr -a k   'kubectl'
abbr -a ke  'kubectl exec -it '
abbr -a kd  'kubectl describe'
abbr -a kg  'kubectl get'
abbr -a kgd 'kubectl get deployments'
abbr -a kgs 'kubectl get services'
abbr -a kge 'kubectl get events'
abbr -a kgk 'kubectl get ksvc'

abbr -a grcat     'grcat conf.cat'
abbr -a ppcatalog 'sudo cat "/opt/puppetlabs/puppet/cache/client_data/catalog/$(sudo puppet config print certname).json" | jq . | less'
abbr -a pwl       'nvim ~/.config/nvim/dictionaries/personal_word_list.txt'

abbr -a cpr  'cp -R'
abbr -a chx  'chmod +x'
abbr -a chR  'chmod -R'
abbr -a rmf  'rm -f'
abbr -a rmrf 'rm -rf'
abbr -a cwd  'pwd | pbcopy'
abbr -a irb  'irb --simple-prompt'

abbr -a d    'docker'
abbr -a dc   'docker compose'
abbr -a dcps 'docker compose ps --format "table {{.Service}}\t{{.State}}\t{{.Status}}"'

if command -v prettyping &>/dev/null
    abbr -a ping 'prettyping --nolegend'
else if command -v hping3 &>/dev/null
    abbr -a ping 'hping3'
end

abbr -a --position=anywhere A '| awk \'{ print $1 }\''
abbr -a --position=anywhere C '| grcat conf.cat'
abbr -a --position=anywhere J '| jq'
abbr -a --position=anywhere G '| grep'
abbr -a --position=anywhere H '| head'
abbr -a --position=anywhere L '| less'
abbr -a --position=anywhere P '| pbcopy'
abbr -a --position=anywhere S '| sort'
abbr -a --position=anywhere T '| tail'
abbr -a --position=anywhere U '| uniq'
abbr -a --position=anywhere V '| nvimpager'
abbr -a --position=anywhere W '| wc -l'

abbr -a urldecode 'python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"'
abbr -a urlencode 'python3 -c "import sys; from urllib.parse import quote; print(quote(sys.stdin.read()));"'

abbr -a whatprovides 'repoquery -q --installed --whatprovides'
abbr -a whatrequires 'repoquery -q --installed --whatrequires'

# !! to show last command similar to bash
function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item
