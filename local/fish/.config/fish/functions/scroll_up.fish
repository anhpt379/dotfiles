function scroll_up
    set -l screen_height $(tput lines)
    if test "$screen_height" -ge 50
        # Scroll up 40 lines from bottom when the screen is high enough.
        #
        # This helps my neck, since it hurts when looking at the bottom of the
        # screen most of the time.
        #
        # We print 40 newlines, then moves the cursor back up 40 lines with the
        # \e[8A escape code, before printing the actual prompt.
        printf '\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\e[40A'
    end
end
