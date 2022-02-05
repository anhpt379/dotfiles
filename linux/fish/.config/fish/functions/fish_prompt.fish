# You can override some default options with config.fish:
#
#  set -g theme_short_path yes

function fish_prompt
    set -l last_command_status $status
    set -l cwd
    set -l fish

    if test "$theme_short_path" = yes
        set cwd (basename (prompt_pwd))
    else
        set cwd (prompt_pwd)
    end

    if [ (uname -s) = 'Darwin' ]
        set fish ""
        set is_darwin
    else
        set fish "⋊>"
    end
    set -l ahead "↑"
    set -l behind "↓"
    set -l diverged "⥄ "
    set -l dirty "⨯"
    set -l none "◦"

    set -l normal_color (set_color normal)
    set -l success_color (set_color cyan)
    set -l error_color (set_color $fish_color_error 2> /dev/null; or set_color red --bold)
    set -l directory_color (set_color white --bold)
    set -l repository_color (set_color yellow)

    if string match -q -- "*.*" (hostname)
        if test "$USER" = root
            set color red
        else
            set color white
        end
        if test $last_command_status -eq 0
            set fish_icon_color cyan
        else
            set fish_icon_color red
        end
        echo -n -s (set_color $color --bold) [$USER@(prompt_hostname) " " $cwd](set_color $fish_icon_color)$fish $normal_color
    else
        if test $last_command_status -eq 0
            echo -n -s (set_color cyan) $fish (set_color -b normal)
        else
            echo -n -s (set_color red) $fish (set_color -b normal)
        end

        if not set -q is_darwin; and git_is_repo
            if test "$theme_short_path" = yes
                set root_folder (command git rev-parse --show-toplevel 2> /dev/null)
                set parent_root_folder (dirname $root_folder)
                set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
            end

            echo -n -s " " $directory_color $cwd $normal_color
            echo -n -s " on " $repository_color (git_branch_name) $normal_color " "

            if git_is_touched
                echo -n -s $dirty
            else
                echo -n -s (git_ahead $ahead $behind $diverged $none)
            end
        else
            echo -n -s " " $directory_color $cwd $normal_color
        end
    end

    echo -n -s "$normal_color "

    # Reset cursor shape to beam
    printf '\033[6 q'

    # z auto remove directories that no longer exist
    if not set -q is_darwin
        z --clean > /dev/null 2>&1
    end
end

