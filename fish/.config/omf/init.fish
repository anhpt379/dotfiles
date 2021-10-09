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

balias ..    'cd ..'
balias ...   'cd ../..'
balias ....  'cd ../../..'
balias ..... 'cd ../../../..'

balias ls  'exa --group-directories-first'
balias la  'exa --group-directories-first -a'
balias ll  'exa --group-directories-first -l'
balias lla 'exa --group-directories-first -la'

balias cat 'bat'
balias ping 'prettyping --nolegend'
balias ncdu 'ncdu -rr -x --exclude .git'
balias fd 'fd --hidden --exclude=".git"'

balias pwl 'nvim ~/.config/nvim/dictionaries/personal_word_list.txt'

balias cmd 'command'
balias d 'docker'
balias dc 'docker-compose'

balias k 'kubectl'
balias kd 'kubectl describe'
balias kdf 'kubectl delete --force --grace-period=0'
balias kn 'kubectl config set-context --current --namespace'

balias http 'xh'
balias https 'xhs'

balias b 'brew'
balias c 'clear'
balias f 'fzf'
balias h 'tldr'
balias j 'z'
balias l 'll'
balias m 'master'
balias n 'note'
balias o 'openstack'

alias view 'nvim -c "set ft=log"'
alias vim  'nvim'

alias nv   'nvim'
alias nf   'nvim +"FilesMru"'
alias ngs  'nvim +"tab Git"'
alias ngl  'nvim +"FzfCommits"'
alias nlf  'nvim +"Lf"'

alias update '\
    brew upgrade;
    fisher self-update;
    fisher;
    omf update;
    pip3 install --upgrade pip;
    brew upgrade neovim-nightly;
    tldr --update;
    pip3 install --user -r ~/dotfiles/requirements.txt;
    gem install --user-install \
        puppet-lint \
        puppet-lint-strict_indent-check \
        puppet-lint-trailing_comma-check \
        puppet-lint-trailing_newline-check \
        solargraph;
'

globabbr C '| grcat conf.auto'
globabbr G '| grep'
globabbr H '| head'
globabbr L '| less'
globabbr T '| tail'
globabbr S '| sort'
globabbr U '| uniq'
globabbr V '| view'
globabbr W '| wc -l'

# Key bindings
bind \cg accept-autosuggestion execute
bind \cz undo

set -x GOROOT /usr/local/opt/go/libexec
set -gx PATH $PATH $HOME/.local/bin

set -gx PATH $HOME/Library/Python/3.7/bin $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH '/usr/local/opt/gnu-sed/libexec/gnubin' $PATH
set -gx PATH '/usr/local/opt/grep/libexec/gnubin' $PATH
set -gx PATH '/usr/local/opt/coreutils/libexec/gnubin' $PATH

# https://github.com/high-moctane/nextword-data
set -gx NEXTWORD_DATA_PATH $HOME/.config/nvim/dictionaries/nextword-data

set -gx EDITOR 'nvim'
set -gx KUBE_EDITOR 'vim'

set -gx MANPAGER "nvim -c 'set ft=man | set showtabline=1 | set laststatus=0' -"

# Fix trackpad scrolling doesn't work in diff-so-fancy
# Need to remove the `X` flag from less options, but can't do it via .gitconfig,
# since git set the default to `FRX` if we don't set `LESS` environment variable
# https://github.com/so-fancy/diff-so-fancy/issues/246
# https://github.com/git/git/blob/v2.7.1/Documentation/config.txt#L646-L648
set -gx LESS 'RM'

# Delete big word with Ctrl+Backspace
bind \cH backward-kill-bigword

# Make reverse word delete work (using ctrl/option+delete)
bind \e\[3\;5~ kill-bigword
bind \e\[3\;3~ kill-word

# Use pageup/pagedown to jump between big words
bind \e\[5~ forward-bigword
bind \e\[6~ backward-bigword

# Fix random command appears when pressing Option-N/P. This maps them to
# Up/Down, to behave the same as Ctrl-N/P.
bind \en down-or-search
bind \ep up-or-search

# Ctrl-D to exit immediately (the default behavior is `delete-or-exit`, which
# is annoying since I can't exit the shell in the middle of typing a command)
bind \cd 'exit'

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

# Fix can't see `null` in jq output (also changed `false` to red, `true` to
# green)
set -gx JQ_COLORS '36:31:32:0;39:0;32:1;39:1;39'

# Custom fish color scheme
set -U fish_color_normal normal
set -U fish_color_command dcdfe4
set -U fish_color_quote ffcc66
set -U fish_color_redirection d3d0c8
set -U fish_color_end cc99cc
set -U fish_color_error dd3c69
set -U fish_color_param dcdfe4
set -U fish_color_comment ffcc66
set -U fish_color_match 6699cc
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 6699cc
set -U fish_color_escape 66cccc
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --bold
set -U fish_color_autosuggestion 747369
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

# lf
set -x LF_ICONS (
  sed ~/.config/lf/icons \
    -e '/^[ \t]*#/d'     \
    -e '/^[ \t]*$/d'     \
    -e 's/[ \t]\+/=/g'   \
    -e 's/$//'           \
  | tr '\n' ':'
)
