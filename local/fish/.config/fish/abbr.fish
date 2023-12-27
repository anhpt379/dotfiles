abbr -a ..    'cd ..'
abbr -a ...   'cd ../..'
abbr -a ....  'cd ../../..'
abbr -a ..... 'cd ../../../..'

abbr -a g   'git'
abbr -a gs  'git status'
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

abbr -a cmd  'command'
abbr -a r    'sudo -E -s fish'
abbr -a root 'sudo -E -s fish'

abbr -a start   'sudo systemctl start'
abbr -a stop    'sudo systemctl stop'
abbr -a restart 'sudo systemctl restart'
abbr -a status  'sudo systemctl status'

abbr -a fd   'command fd --one-file-system --hidden --exclude=".git"'
abbr -a ncdu 'ncdu -rr -x --exclude .git'

abbr -a docker         'sudo -E docker'
abbr -a docker-compose 'sudo -E docker-compose'
abbr -a d    'sudo -E docker'
abbr -a dl   'sudo -E docker logs'
abbr -a dps  'sudo -E docker ps'
abbr -a dc   'sudo -E docker-compose'
abbr -a dcu  'sudo -E docker-compose up --build -d'
abbr -a dcup 'sudo -E docker-compose up --build -d'
abbr -a dcr  'sudo -E docker-compose restart'
abbr -a dcs  'sudo -E docker-compose stop'
abbr -a dcps 'sudo -E docker-compose ps'

abbr -a http  'xh'
abbr -a https 'xhs'

abbr -a k   'kubectl'
abbr -a kd  'kubectl describe'
abbr -a kdf 'kubectl delete --force --grace-period=0'
abbr -a kn  'kubectl config set-context --current --namespace'

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

if command -v prettyping &>/dev/null
    abbr -a ping 'prettyping --nolegend'
else if command -v hping3 &>/dev/null
    abbr -a ping 'hping3'
end

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
