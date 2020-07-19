function fco --description 'Fuzzy-find and checkout a branch'
    git rev-parse HEAD >/dev/null 2>&1 || return

    git branch --sort=-committerdate --all | \
        grep -v HEAD | \
        string trim | \
        fzf --preview-window=right:60% --preview \
        'git log -n 50 --color=always --date=relative --abbrev=7 --pretty="format:%C(auto,yellow)%h %C(auto,blue)%>(12,trunc)%ad %C(auto,green)%<(10,trunc)%aN %C(auto,reset)%s%C(auto,red)% gD% D" (echo {} | sed "s/.* //")' | \
        read -l result; and git checkout "$result"
end
