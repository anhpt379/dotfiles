function ll
    if command -v eza >/dev/null
        command eza --group-directories-first --classify=always -l $argv
    else
        command ls --color=yes --group-directories-first -vF -lh $argv
    end
end
