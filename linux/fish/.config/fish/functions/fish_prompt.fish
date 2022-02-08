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
    set -l directory_color
    set -l user_color

    if test $last_command_status -eq 0
        set directory_color (set_color fefefe)
    else
        set directory_color (set_color ee0b4f)
    end

    if test $kernel = "Darwin"
        echo -n -s " "
    end

    echo -n -s $prompt_background_color

    if string match -q -- "*.*" (hostname)
        if test "$USER" = root
            set user_color (set_color ee0b4f)
        else
            set user_color (set_color fefefe)
        end
        echo -n -s $user_color $USER@(prompt_hostname)
        echo -n -s $directory_color " " $cwd " "

        # Fix z keeps asking for permission to update $Z_DATA file when it's
        # owned by `root`
        if set -q BOOKING_USER
            sudo chown -R $BOOKING_USER $Z_DATA
        end
    else
        if test $kernel = "Linux"; and git_is_repo
            echo -n -s $directory_color " " $cwd " "
            echo -n -s $repository_color (git_branch_name) " "

            set -l git_ahead_status (git_ahead $ahead $behind $diverged $none)

            if git_is_touched
                echo -n -s $dirty " "
            else if test "$git_ahead_status" != ""
                echo -n -s $git_ahead_status " "
            end
        else
            echo -n -s $directory_color " " $cwd " "
        end
    end

    echo -n -s $normal_color " "

    # Reset cursor shape to beam
    printf '\033[6 q'
end
