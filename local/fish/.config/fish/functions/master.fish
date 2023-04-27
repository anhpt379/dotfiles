function master
    set default_branch_name (git branch | grep -o -m1 "\b\(master\|main\)\b")
    git checkout $default_branch_name
    git diff-index --quiet HEAD && git pull --rebase origin $default_branch_name
end
