function clear
    if set -q TMUX
        tput reset
    else
        command clear
    end
end
