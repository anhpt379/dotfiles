function fish_title
    if string match -e -q -- fedora $(hostname); and test -n "$TMUX"
        if test $_ = fish
            set title $(prompt_pwd)
        else if string match -r -- ".*ssh .*" $argv
            set title $(echo $argv  | cut -d. -f1-2)
        else
            set title "$_ $(prompt_pwd)"
        end
        tmux rename-window $(echo $title | python3 -c "import sys; print('{:^10}'.format(sys.stdin.read().strip()))")
    end
end
