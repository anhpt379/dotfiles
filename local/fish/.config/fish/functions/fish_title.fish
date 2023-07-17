function fish_title
    if string match -e -q -- fedora $(hostname); and test -n "$TMUX"
        if string match -r -- ".*ssh .*" $argv
            set title $(echo $argv  | cut -d. -f1-2)
        else
            set cwd $(prompt_pwd | string replace -- "~/" "" | string replace -- "~" "")
            set title "$_ $cwd"
        end
        tmux rename-window $title
    end
end
