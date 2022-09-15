# grc fish integration
if [ -f ~/.cargo/bin/grc-rs ]
    alias grc   'grc-rs'
    alias grcat 'grc-rs --colour=on cat'
    source /etc/grc.fish
else
    alias grcat 'grcat conf.cat'
end

alias root 'sudo -E -s fish'

# systemctl aliases
alias start     'sudo systemctl start'
alias stop      'sudo systemctl stop'
alias restart   'sudo systemctl restart'
alias info      'sudo systemctl status'
function log
    SYSTEMD_PAGER=cat sudo journalctl -u $argv | \
        nvimpager -- --cmd "autocmd VimEnter * :normal G"
end

# git
alias g        'git'
alias gs       'git status'
alias push     'git push origin'
alias fetch    'git fetch origin'
function reset -d "git fetch reset"
    if not git cat-file -e $argv 2> /dev/null;
        git fetch origin
    end
    git reset --hard $argv
end
alias rebase   'git rebase'
alias master   'git checkout (git branch | grep -o -m1 "\b\(master\|main\)\b"); git diff-index --quiet HEAD && git pull --rebase origin (git branch | grep -o -m1 "\b\(master\|main\)\b")'
alias gadd     'git add'
alias gpush    'git push'
alias gpull    'git pull'
alias gfetch   'git fetch'
alias gco      'git checkout'
alias glog     'git log'
alias greset   'git reset'
alias grevert  'git revert'
alias grestore 'git restore'
alias grebase  'git rebase'
alias gdiff    'git diff'
alias gshow    'git show'
alias gstash   'git stash'
alias gclone   'git clone'
alias gremote  'git remote'
alias gbranch  'git branch'

alias cat  'less'
alias ping 'prettyping --nolegend'
alias ncdu 'ncdu -rr -x --exclude .git'
alias fd   'fd --hidden --exclude=".git"'
alias view 'nvimpager -p'

alias pwl 'nvim ~/.config/nvim/dictionaries/personal_word_list.txt'

alias docker         'sudo -E docker'
alias docker-compose 'sudo -E docker-compose'

alias ansible          'TERM=xterm-256color command ansible'
alias ansible-playbook 'TERM=xterm-256color command ansible-playbook'

alias k   'kubectl'
alias kd  'kubectl describe'
alias kdf 'kubectl delete --force --grace-period=0'
alias kn  'kubectl config set-context --current --namespace'

alias http  'xh'
alias https 'xhs'

alias j 'z'
alias b 'brew'
alias f 'fzf'
alias h 'tldr'
alias l 'll'
alias m 'master'
alias n 'note'
alias o 'openstack'

alias vim 'nvim'

alias nf  'nvim +"FilesMru"'
alias ngs 'nvim +"tab Git"'
alias ngl 'nvim +"FzfCommits"'
alias nlf 'nvim +"Lf"'
alias nv  'nvim $argv'

function update
    cd ~/dotfiles/local/ && brew bundle
    fisher update
    omf update
    tldr --update
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

alias urldecode 'python3 -c "import sys, urllib.parse; print(urllib.parse.unquote_plus(sys.argv[1]))"'
alias urlencode 'python3 -c "import sys, urllib.parse; print(urllib.parse.quote_plus(sys.argv[1]))"'

globabbr C '| grcat'
globabbr J '| jq'
globabbr G '| grep'
globabbr H '| head'
globabbr L '| less'
globabbr P '| pbcopy'
globabbr S '| sort'
globabbr T '| tail'
globabbr U '| uniq'
globabbr V '| nvimpager'
globabbr W '| wc -l'

set -gx no_proxy localhost,.$COMPANY_DOMAIN

set -gx HOMEBREW_BUNDLE_FILE "~/.Brewfile"
set -gx GOPATH $HOME/.go

if test -f /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

set -gx PATH /opt/homebrew/opt/grep/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/gnu-sed/libexec/gnubin $PATH
set -gx PATH /opt/homebrew/opt/coreutils/libexec/gnubin $PATH
set -gx PATH $HOME/.go/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/.local/bin/nvim-appimage/squashfs-root/usr/bin/ $PATH
set -gx PATH $HOME/.local/bin $PATH

# https://github.com/high-moctane/mocword
set -gx MOCWORD_DATA $HOME/.config/nvim/dictionaries/mocword.sqlite

set -gx EDITOR 'nvim'
set -gx KUBE_EDITOR 'vim'

set -gx MANPAGER  "less"
set -gx PAGER     "nvimpager -p"

# Fix trackpad scrolling doesn't work in diff-so-fancy
# Need to remove the `X` flag from less options, but can't do it via .gitconfig,
# since git set the default to `FRX` if we don't set `LESS` environment variable
# https://github.com/so-fancy/diff-so-fancy/issues/246
# https://github.com/git/git/blob/v2.7.1/Documentation/config.txt#L646-L648
set -gx LESS '--LONG-PROMPT --RAW-CONTROL-CHARS'

# Edit and run the current command in vim
bind \cv edit_and_run_command_buffer

# Make Control+W (or Option+Delete) in fish works similar to vim. By default,
# fish binds it to `backward-kill-path-component`, which doesn't respect the
# `-` character in the middle of a word.
bind \cw backward-kill-word

bind \b backward-kill-bigword

# Fzf
bind --erase \co
bind \t  'fzf_complete'
bind \cf 'fzf_find'
bind \cr 'fzf_history'
# bind \t  '__fish_expand_globabbreviation || fzf_complete'

# Fix fzf couldn't preview matches that end with `\`. This happens in fish
# only. Fzf uses the shell set in SHELL env to execute the preview command.
# https://github.com/junegunn/fzf/blob/0.25.0/src/util/util_unix.go#L13
set -gx SHELL '/bin/bash'

set -gx Z_DATA "$HOME/.local/share/z/data"

set -gx FZF_DEFAULT_COMMAND 'fd --hidden --type f --color=never --exclude ".git" -E "*.jp*g" -E "*.png"'
set -gx FZF_PREVIEW_COMMAND '~/.local/bin/fzf-preview.sh {}'
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
  --bind=ctrl-h:backward-kill-word
'

# lf
set -gx LF_ICONS (
    sed ~/.config/lf/icons \
        -e '/^[ \t]*#/d'   \
        -e '/^[ \t]*$/d'   \
        -e 's/[ \t]\+/=/g' \
        -e 's/$//'         \
    | tr '\n' ':'
)

# search a server by fqdn prefix and open it in serverdb
function sdb
    set -l query $argv[1]
    set -l fqdn (cat ~/.cache/servers.txt | grep ^$query | head -1 | xargs)
    if test -n $fqdn
        set -l id (curl -s https://simpleapi.prod.$COMPANY_DOMAIN/servers/$fqdn | jq .server.id)
        open https://serverdb.$COMPANY_DOMAIN/hud/v/servers/server/$id/
    else
        echo "No servers found"
    end
end
