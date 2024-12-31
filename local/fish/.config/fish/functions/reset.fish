function reset
    set sleep 0
    while ! git cat-file -e "$argv[1]" 2>/dev/null
        sleep $sleep
        echo "$argv[1] not found locally. Fetching from remote..."
        git fetch origin "$argv[1]"
        set sleep 1
    end
    git reset --hard "$argv[1]"
end
