function note -d "Manage notes in ~/Workspace/notes"
    set current_dir (pwd)

    cd ~/Workspace/notes/
    set file_to_open (
        echo (
            for i in *; preview=(head $i | awk '!/^ *#/ && NF' | head -1 | awk -v len=50 '{ if (length($0) > len) print substr($0, 1, len-3) "..."; else print; }') echo -e "$i \e[2m$preview\e[0m"; end | devicon-lookup | \
            fzf --preview="bat --color=always --line-range :100 (echo {} | cut -d' ' -f2)" \
                --preview-window=right:70% \
                --height=100% --print-query --ansi | \
            tail -1
        ) | cut -d' ' -f2
    )
    if string length -q -- "$file_to_open"
        nvim $file_to_open
    end

    cd $current_dir
end
