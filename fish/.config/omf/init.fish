balias k kubectl
balias kd 'kubectl describe'
balias kdf 'kubectl delete --force --grace-period=0'
balias kn 'kubens'
balias kc 'kubectx'

balias ga 'git commit --amend'
balias gc 'git commit'
balias gf 'git fetch'
balias gr 'git reset'
balias gs 'git status'
balias gb 'git branch -v'
balias gl 'tig'
balias gpush 'git push'
balias gpull 'git pull'
balias gdiff 'git diff'

balias ls 'exa --group-directories-first'
balias la 'exa -a --group-directories-first'
balias ll 'exa -la --group-directories-first'

balias cat 'bat'
balias ping 'prettyping --nolegend'
balias ncdu 'ncdu -rr -x --exclude .git'

balias d 'docker'
balias dc 'docker-compose'

balias c 'clear'
balias j 'z'
balias f 'fzf'
balias r 'ranger'

bind \cf accept-autosuggestion execute
bind \cx execute

set -x GOROOT /usr/local/opt/go/libexec
set -x GOPATH $HOME/.go
set -gx PATH $PATH $HOME/.krew/bin

set -gx PATH $HOME/Library/Python/3.7/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx fish_user_paths '/usr/local/opt/curl/bin' $fish_user_paths

# Fzf
bind \co 'fzf_find'
bind \cr 'fzf_history'

set -gx FZF_DEFAULT_COMMAND        'fd --hidden --exclude ".git"'
set -gx FZF_DEFAULT_OPTS           '--pointer=" >" --prompt="  " --color fg:#DCDFE4,bg:-1,hl:#55CABE,fg+:#FFCC66,bg+:#1C1E23,hl+:#00bdbd,info:#919BAA,prompt:#C068DF,pointer:#3BB0E0,marker:#55CABE,spinner:#919BAA --no-multi --reverse --height=40% --info=inline --bind=tab:accept'

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
set -U fish_color_valid_path --underline
set -U fish_color_autosuggestion 747369
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan

