function pull -d "git pull"
    if [ (count $argv) -lt 2 ]
        git pull --rebase origin $argv
    else
        git pull --rebase $argv
    end
end
