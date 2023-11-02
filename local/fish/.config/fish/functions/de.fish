function de -d "Copy dotfiles & exec to a docker container"
    for i in .bashrc .bash_aliases .vimrc .inputrc .less
        docker cp ~/$i $argv[1]:/root/ >/dev/null
    end

    if test $(count $argv) -eq 1
        sudo -E docker exec -it $argv bash
    else
        sudo -E docker exec -it $argv
    end
end
