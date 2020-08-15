function gb --description 'Fuzzy-find and checkout a branch'
    git rev-parse HEAD || return

    git branch --sort=-committerdate | \
        grep -v HEAD | \
        string trim | \
        fzf --preview-window=right:75% --height=100% --preview \
            'git log -n 50 --color=always --date=relative --abbrev=7 \
                --pretty="format:%C(auto,blue)%>(12,trunc)%ad %C(auto,yellow)%h %C(auto,green)%aN %C(auto,reset)%s%C(auto,red)% gD% D" \
                (echo {} | sed "s/.* //")' | \
        read -l result; and git checkout "$result"
end
