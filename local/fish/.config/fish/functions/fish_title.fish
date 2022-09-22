function fish_title
    if test (uname -s) = Darwin
        echo -n " "
    end
    echo (status current-command) (prompt_pwd)
end
