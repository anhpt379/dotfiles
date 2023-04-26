function la
    if command -v exa >/dev/null
        command exa --group-directories-first -F -a $argv
    else
        command ls --color=yes --group-directories-first -vFA $argv
    end
end

