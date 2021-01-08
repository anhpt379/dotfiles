function gb --description 'Fuzzy-find and checkout a branch'
    git rev-parse HEAD >/dev/null; or return

    set get_branch_name "echo -n {} | sed 's/.* //'"
    set preview_cmd "git log -n 50 \
                        --color=always \
                        --date=relative \
                        --abbrev=7 \
                        --pretty='format:%C(auto,blue)%>(12,trunc)%ad %C(auto,yellow)%h %C(auto,green)%aN %C(auto,reset)%s%C(auto,red)% gD% D' \
                        `echo -n {} | sed 's/.* //'` --"
    set result (
        git branch --sort=-committerdate \
            | grep -v HEAD \
            | string trim \
            | fzf --height=100% \
                  --preview-window=right:75% \
                  --exact \
                  --print-query \
                  --expect=ctrl-d \
                  --preview="$preview_cmd" \
                  --header="(Press CTRL-Y to copy, CTRL-D to delete, ENTER to checkout)" \
                  --bind="ctrl-y:execute-silent/$get_branch_name | pbcopy/+abort"
        )

    set key (echo $result | xargs | cut -d' ' -f1)
    set branch_name (echo $result | xargs | cut -d' ' -f2- | sed 's/.* //')

    if test "$key" = ctrl-d
        if test (git branch --show-current) = "$branch_name"
            git checkout master && git branch -d $branch_name
        else
            git branch -d $branch_name
        end
    else
        git checkout (git show-ref --verify --quiet refs/heads/$branch_name || echo '-b') $branch_name
    end
end
