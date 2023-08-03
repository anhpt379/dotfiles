function fish_title
    if test -n "$TMUX"
        if string match -r -- ".*ssh .*" $argv
            set title $(echo $argv  | cut -d. -f1-2)
        else
            set cwd $(prompt_pwd | string replace -- "~/" "" | string replace -- "~" "")
            set title "$_ $cwd"
        end

        echo -e "\e]2;$title\e\\"
    else
        if test $(uname -s) = Darwin
            echo -n " "
        end
        echo $(status current-command) $(prompt_pwd)
    end
end
