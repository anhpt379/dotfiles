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
balias gpush 'git pushf'
balias gpull 'git pull'

balias ls 'exa'
balias la 'exa -a'
balias ll 'exa -la'

balias cat 'bat'

balias d 'docker'
balias dc 'docker-compose'

balias c 'clear'
balias j 'z'
balias f 'fzf --reverse --height=40%'

set -x GOROOT /usr/local/opt/go/libexec
set -x GOPATH $HOME/.go
set -gx PATH $PATH $HOME/.krew/bin

set -gx PATH $HOME/Library/Python/3.7/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx fish_user_paths '/usr/local/opt/curl/bin' $fish_user_paths

# Fzf
set -U FZF_COMPLETE 2
set -U FZF_FIND_FILE_COMMAND 'fd --type f --hidden --exclude ".git" . \$dir'
set -U FZF_CD_COMMAND 'fd --type d'
set -U FZF_CD_WITH_HIDDEN_COMMAND 'fd --type d --hidden --exclude ".git"'
set -U FZF_PREVIEW_FILE_CMD 'bat --color=always --style=numbers --line-range :300'
set -U FZF_PREVIEW_DIR_CMD 'exa -la --color=always'
set -U FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude ".git"'
set -U FZF_DEFAULT_OPTS '--no-multi --reverse --height=40% --info=default'
set -U FZF_FIND_FILE_OPTS $FZF_DEFAULT_OPTS

function __fzf_search_current_dir --description "Search the current directory using fzf and fd. Insert the selected filenames into the commandline at the cursor."
    set files_selected (
        fd --type f --hidden --follow --color=always --exclude=.git 2> /dev/null |
        fzf --ansi --reverse --height=40%
    )

    if test $status -eq 0
        commandline --insert (echo $files_selected | xargs) # doesn't string escape so won't work with weird filenames
        commandline --insert " "
    end

    commandline --function repaint
end
bind \cd '__fzf_search_current_dir'

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

