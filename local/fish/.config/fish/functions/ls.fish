function ls
    if command -v eza >/dev/null
        command eza --group-directories-first --classify=always $argv
    else
        command ls --color=yes --group-directories-first -vF $argv
    end
end
