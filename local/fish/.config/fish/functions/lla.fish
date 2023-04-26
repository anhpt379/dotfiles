function lla
    if command -v exa >/dev/null
        command exa --group-directories-first -F -la $argv
    else
        command ls --color=yes --group-directories-first -vF -lhA
    end
end
