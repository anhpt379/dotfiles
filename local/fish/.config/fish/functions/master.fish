function master
    set default_branch_name $(git branch | grep -Eo " \b(master|main)\b" | xargs)
    git checkout $default_branch_name
    git diff-index --quiet HEAD && git pull --rebase origin $default_branch_name
end
