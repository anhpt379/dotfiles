alias root 'sudo -E -s fish'
alias sudo 'sudo -E'

# systemctl aliases
alias start="sudo systemctl start"
alias stop="sudo systemctl stop"
alias restart="sudo systemctl restart"
alias info="sudo systemctl status"
alias log="sudo journalctl -e -u"

# git
balias g        'git'
balias gs       'git status'
balias push     'git push origin'
balias fetch    'git fetch origin'
function reset -d "git fetch reset"
    if not git cat-file -e $argv 2> /dev/null;
        git fetch origin
    end
    git reset --hard $argv
end
balias rebase   'git rebase'
balias master   'git checkout master; git diff-index --quiet HEAD && git pull --rebase origin master'
balias gadd     'git add'
balias gpush    'git push'
balias gpull    'git pull'
balias gfetch   'git fetch'
balias gco      'git checkout'
balias glog     'git log'
balias greset   'git reset'
balias grevert  'git revert'
balias grestore 'git restore'
balias grebase  'git rebase'
balias gdiff    'git diff'
balias gshow    'git show'
balias gstash   'git stash'
balias gclone   'git clone'
balias gremote  'git remote'
balias gbranch  'git branch'

balias cat 'bat'
balias ping 'prettyping --nolegend'
balias ncdu 'ncdu -rr -x --exclude .git'
balias fd 'fd --hidden --exclude=".git"'

balias pwl 'nvim ~/.config/nvim/dictionaries/personal_word_list.txt'

balias d 'sudo docker'
balias ds 'sudo docker ps'
balias dc 'sudo docker-compose'

balias k 'kubectl'
balias kd 'kubectl describe'
balias kdf 'kubectl delete --force --grace-period=0'
balias kn 'kubectl config set-context --current --namespace'

balias http 'xh'
balias https 'xhs'

balias j 'z'
balias b 'brew'
balias f 'fzf'
balias h 'tldr'
balias l 'll'
balias m 'master'
balias n 'note'
balias o 'openstack'

alias view 'nvim -c "set ft=log"'
alias vim  'nvim'

alias nf   'nvim +"FilesMru"'
alias ngs  'nvim +"tab Git"'
alias ngl  'nvim +"FzfCommits"'
alias nlf  'nvim +"Lf"'
function nv
    echo (pwd) > ~/.cache/nvim/cwd
    nvim $argv
    rm -f ~/.cache/nvim/cwd
end

function update
    fisher update
    omf update
    tldr --update
end

globabbr C '| grcat'
globabbr G '| grep'
globabbr H '| head'
globabbr L '| less'
globabbr T '| tail'
globabbr S '| sort'
globabbr U '| uniq'
globabbr V '| view'
globabbr W '| wc -l'

set -gx PATH $PATH $HOME/.local/bin

set -gx GOPATH $HOME/.go

set -gx PATH $HOME/.go/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH

# https://github.com/high-moctane/nextword-data
set -gx NEXTWORD_DATA_PATH $HOME/.config/nvim/dictionaries/nextword-data

set -gx EDITOR 'nvim'
set -gx KUBE_EDITOR 'vim'

set -gx MANPAGER "nvim -c 'set ft=man | set showtabline=1 | set laststatus=0' +Man!"

# Fix trackpad scrolling doesn't work in diff-so-fancy
# Need to remove the `X` flag from less options, but can't do it via .gitconfig,
# since git set the default to `FRX` if we don't set `LESS` environment variable
# https://github.com/so-fancy/diff-so-fancy/issues/246
# https://github.com/git/git/blob/v2.7.1/Documentation/config.txt#L646-L648
set -gx LESS 'RM'

# Edit and run the current command in vim
bind \ce edit_and_run_command_buffer

# Fzf
bind --erase \co
bind \cf 'fzf_find'
bind \cr 'fzf_history'
# bind \t  '__fish_expand_globabbreviation || fzf_complete'

# Fix fzf couldn't preview matches that end with `\`. This happens in fish
# only. Fzf uses the shell set in SHELL env to execute the preview command.
# https://github.com/junegunn/fzf/blob/0.25.0/src/util/util_unix.go#L13
set -gx SHELL '/bin/bash'

set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f --color=never --exclude ".git" -E "*.jp*g" -E "*.png"'
set -gx FZF_DEFAULT_PREVIEW_COMMAND '~/.local/bin/fzf-preview.sh {}'
set -gx FZF_DEFAULT_OPTS    '
  --pointer=" " --prompt="> "
  --color=fg:#DCDFE4,bg:-1,hl:#DCDFE4
  --color=fg+:#FFCC66,bg+:#262626,hl+:#FFCC66
  --color=prompt:#f1f1f1,pointer:#f1f1f1
  --color=info:#555555,spinner:#555555
  --color=marker:#55CABE
  --color=spinner:108
  --cycle
  --no-multi
  --reverse
  --height=40%
  --preview-window=right:60%
  --bind=ctrl-/:toggle-preview
  --bind=ctrl-s:toggle-sort
  --bind=tab:accept,ctrl-j:ignore,ctrl-k:ignore
  --bind=change:first
  --bind=ctrl-f:preview-page-down,ctrl-b:preview-page-up
'

# lf
set -gx LF_ICONS (
  sed ~/.config/lf/icons \
    -e '/^[ \t]*#/d'     \
    -e '/^[ \t]*$/d'     \
    -e 's/[ \t]\+/=/g'   \
    -e 's/$//'           \
  | tr '\n' ':'
)

# grc fish integration
if type -q grc-rs
    alias grc   'grc-rs'
    alias grcat 'grc-rs --colour=on cat'
    source /etc/grc.fish
else
    alias grcat 'grcat conf.cat'
end
