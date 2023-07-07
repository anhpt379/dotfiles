function fish_title
    if test $_ = "fish"
        tmux rename-window $(prompt_pwd)
    else
        tmux rename-window "$_ $(prompt_pwd)"
    end
end
