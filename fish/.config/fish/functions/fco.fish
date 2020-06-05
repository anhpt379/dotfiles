function fco --description 'Fuzzy-find and checkout a branch'
  git rev-parse HEAD > /dev/null 2>&1 || return

	git branch --sort=-committerdate --all | \
    grep -v HEAD | \
    string trim | \
    fzf --preview \
      'git log -n 50 --color=always --date=short --pretty="format:%C(auto)%cd %h%d %s" (echo {} | sed "s/.* //")' | \
    read -l result; and git checkout "$result"
end

