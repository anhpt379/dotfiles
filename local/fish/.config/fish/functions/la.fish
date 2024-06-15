function la
    if command -v eza >/dev/null
        command eza --group-directories-first -F -a $argv
    else
        command ls --color=yes --group-directories-first -vFA $argv
    end
end

