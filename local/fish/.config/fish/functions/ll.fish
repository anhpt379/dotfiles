function ll
    if command -v exa >/dev/null
        command exa --group-directories-first -F -l $argv
    else
        command ls --color=yes --group-directories-first -vF -lh $argv
    end
end
