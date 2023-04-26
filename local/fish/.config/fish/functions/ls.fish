function ls
    if command -v exa >/dev/null
        command exa --group-directories-first -F $argv
    else
        command ls --color=yes --group-directories-first -vF $argv
    end
end
