function fish_prompt
    set -l last_command_status $status
    set -l duration_seconds $(math round $CMD_DURATION / 1000)
    if test $duration_seconds -ge 2
        set_color yellow
        echo "Executed in $(humantime $CMD_DURATION)"
        set -g CMD_DURATION 0
        set_color white
    end

    set -l cwd (prompt_pwd)
    set -l kernel (uname -s)

    set -l ahead "↑"
    set -l behind "↓"
    set -l diverged "⥄ "
    set -l dirty "✗"
    set -l none "✓"

    set -l normal_color (set_color normal)
    set -l repository_color (set_color yellow)
    set -l prompt_background_color (set_color -b 262626)

    if string match -q -- "*.*" (hostname -f)
        echo -n -s $prompt_background_color
        echo -n -s "["

        if test "$USER" = root
            set_color red
        else
            set_color white
        end

        echo -n -s (prompt_hostname)

        if test $last_command_status -eq 0
            set_color yellow
        else
            set_color red
        end

        echo -n -s " " $cwd
        echo -n -s $normal_color $prompt_background_color "]"

        # Fix nvim permission issues when switching to root
        if test "$USER" = root
            if test -d ~/.local/state/nvim/
                chown -R panh ~/.local/state/nvim/
            end

            if test -f ~/.cache/fzf_filemru
                chown panh ~/.cache/fzf_filemru
            end
        end

    else
        if test $kernel = Darwin
            echo -n -s " "
        end

        # The character below I use it as a marker, when combining with tmux
        # `search-backward` we can jump to the previous/next prompt in the scrollback
        # (by searching for the character).
        if test $last_command_status -eq 0
            echo -n -s (set_color cyan) "█"
        else
            echo -n -s (set_color red) "█"
        end

        set_color white
        echo -n -s $prompt_background_color

        if test $kernel = Linux; and git_is_repo
            echo -n -s " " $cwd " "
            echo -n -s $repository_color (git_branch_name) " "

            set -l git_ahead_status (git_ahead $ahead $behind $diverged $none)

            if git_is_touched
                echo -n -s $dirty " "
            else if test "$git_ahead_status" != ""
                echo -n -s $git_ahead_status " "
            end
        else
            echo -n -s " " $cwd " "
        end
    end

    echo -n -s $normal_color " "

    # Reset cursor shape to blinking bar
    printf '\e[5 q'
end
