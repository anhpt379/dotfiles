function lla
    if command -v eza >/dev/null
        command eza --group-directories-first -F -la $argv
    else
        command ls --color=yes --group-directories-first -vF -lhA $argv
    end
end
