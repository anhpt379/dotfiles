function gb --description 'Fuzzy-find and checkout a branch'
    git rev-parse HEAD >/dev/null; or return

    set branch_name "echo -n {} | sed 's/.* //'"
    set preview_cmd "git log -n 50 \
                        --color=always \
                        --date=relative \
                        --abbrev=7 \
                        --pretty='format:%C(auto,blue)%>(12,trunc)%ad %C(auto,yellow)%h %C(auto,green)%aN %C(auto,reset)%s%C(auto,red)% gD% D' \
                        (echo {} | sed 's/.* //')"
    set copy_branch "$branch_name | pbcopy"
    set checkout_branch "git checkout `$branch_name`"
    set delete_branch "git branch -d `$branch_name`"

    git branch --sort=-committerdate \
      | grep -v HEAD \
      | string trim \
      | fzf --height=100% --preview-window=right:75% \
        --print-query \
        --preview="$preview_cmd" \
        --header="(Press CTRL-Y to copy, CTRL-D to delete, ENTER to checkout)" \
        --bind="enter:execute/$checkout_branch/+abort" \
        --bind="ctrl-d:execute/$delete_branch/+abort" \
        --bind="ctrl-y:execute-silent/$copy_branch/+abort"
end
