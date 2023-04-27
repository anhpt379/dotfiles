function clear
    if set -q TMUX
        tput reset
    else
        # https://superuser.com/a/1667623
        if test (count $argv) -ne 0
            command clear "$argv"
        else
            set count (tput lines 2>/dev/null)
            while test $count -gt 1
                printf '\n'
                set count (math $count - 1)
            end

            command clear -x
        end
    end
end
