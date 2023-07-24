function fish_title
    if test -n "$TMUX"
        if string match -r -- ".*ssh .*" $argv
            set title $(echo $argv  | cut -d. -f1-2)
        else
            set cwd $(prompt_pwd | string replace -- "~/" "" | string replace -- "~" "")
            set title "$_ $cwd"
        end

        # Only rename window if this is the main pane
        if test $(tmux display -p '#{pane_index}') -eq 1
            tmux rename-window $title
        end
    else
        if test $(uname -s) = Darwin
            echo -n " "
        end
        echo $(status current-command) $(prompt_pwd)
    end
end
