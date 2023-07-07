function fish_title
    if test -n "$TMUX"
        if test $_ = fish
            tmux rename-window $(prompt_pwd)
        else if string match -r -- ".*ssh .*" $argv
            tmux rename-window $(echo $argv  | cut -d. -f1-2)
        else
            tmux rename-window "$_ $(prompt_pwd)"
        end
    end
end
