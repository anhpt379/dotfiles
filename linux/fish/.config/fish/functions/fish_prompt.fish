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
    set -l directory_background_color (set_color -b 333)
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

    if string match -q -- "*.*" (hostname)
        if test "$USER" = root
            set user_color (set_color ee0b4f)
        else
            set user_color (set_color fefefe)
        end
        echo -n -s $directory_background_color $user_color $USER@(prompt_hostname) $directory_color " " $cwd " " $normal_color
    else
        if test $kernel = "Linux"; and git_is_repo
            echo -n -s $directory_background_color $directory_color " " $cwd " " $normal_color
            echo -n -s " " $repository_color (git_branch_name)

            set -l git_ahead_status (git_ahead $ahead $behind $diverged $none)

            if git_is_touched
                echo -n -s " " $normal_color $dirty
            else if test "$git_ahead_status" != ""
                echo -n -s " " $normal_color $git_ahead_status
            end
        else
            echo -n -s $directory_background_color $directory_color " " $cwd " "
        end
    end

    echo -n -s $normal_color " "

    # Reset cursor shape to beam
    printf '\033[6 q'
end

