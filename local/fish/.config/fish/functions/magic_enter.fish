function magic_enter
    set -l command $(commandline)

    if test -z $command
        set -l screen_height $(tput lines)
        if test $screen_height -gt 40
            # Scroll up 20 lines from bottom when the screen is high enough.
            #
            # This helps my neck, since it hurts when looking at the bottom of the
            # screen most of the time.
            #
            # We print 20 newlines, then moves the cursor back up 20 lines with the
            # \e[8A escape code, before printing the actual prompt.
            printf '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\e[20A'
        end
    end

    commandline -f execute
end
