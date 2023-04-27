function reset
    if ! git cat-file -e "$argv[1]" 2>/dev/null
        git fetch origin
    end
    git reset --hard "$argv[1]"
end
