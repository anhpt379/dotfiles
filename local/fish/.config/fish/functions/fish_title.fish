function fish_title
    if string match -e -q -- fedora $(hostname); and test -n "$TMUX"
        if test $_ = fish
            set cwd $(prompt_pwd | python3 -c "import sys; print('{:^10}'.format(sys.stdin.read().strip()))")
            tmux rename-window $cwd
        else if string match -r -- ".*ssh .*" $argv
            tmux rename-window $(echo $argv  | cut -d. -f1-2)
        else
            tmux rename-window "$_ $(prompt_pwd)"
        end
    end
end
