function fish_title
    if test -n "$TMUX"
        # Only set tab title if this is the main pane
        if test $(tmux display -p '#{pane_index}') -eq 1
            if string match -r -- ".*ssh .*" $argv
                set title $(echo $argv  | cut -d. -f1-2)
            else
                set cwd $(prompt_pwd | string replace -- "~/" "" | string replace -- "~" "" | xargs)
                if test -n $cwd
                    set title "$_ $cwd"
                else
                    set title "$_"
                end
            end

            printf "\ek$title\e\\"
        end
    else
        echo $(status current-command) $(prompt_pwd)
    end
end
