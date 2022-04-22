function fish_prompt
    set -l last_command_status $status

    set -l cwd (prompt_pwd)
    set -l kernel (uname -s)

    set -l ahead "↑"
    set -l behind "↓"
    set -l diverged "⥄ "
    set -l dirty "⨯"
    set -l none "◦"

    set -l normal_color (set_color normal)
    set -l repository_color (set_color yellow)
    set -l prompt_background_color (set_color -b 333)
    set -l user_color

    if string match -q -- "*.*" (hostname -f)
        if test "$USER" = root
            set user_color (set_color red)
        else
            set user_color (set_color white)
        end

        echo -n -s $prompt_background_color
        echo -n -s "[" $user_color $USER@(prompt_hostname)
        echo -n -s " " $repository_color $cwd $normal_color $prompt_background_color "]"

        # Fix z keeps asking for permission to update $Z_DATA file when it's
        # owned by `root`
        if test "$USER" = root; and set -q "$COMPANY_NAME_UPPER"_USER
            chown -R panh $Z_DATA
        end
    else
        if test $kernel = "Darwin"
            echo -n -s " "
        end

        # The space we see below is not a normal space, it's a thin space (U+2009).
        # I use it as a marker, when combining with tmux `search-backward` we can
        # jump to the previous/next prompt in the scrollback (by searching for the
        # character).
        if test $last_command_status -eq 0
            echo -n -s (set_color -b cyan) " "
        else
            echo -n -s (set_color -b red) " "
        end

        echo -n -s $prompt_background_color

        if test $kernel = "Linux"; and git_is_repo
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

    # z auto remove directories that no longer exist
    if type -q z
        z --clean > /dev/null 2>&1
    end

    echo -n -s $normal_color " "

    # Reset cursor shape to beam
    printf '\033[6 q'
end
