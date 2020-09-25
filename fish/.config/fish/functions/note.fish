function note -d "Manage notes in ~/Workspace/notes"
    set current_dir (pwd)

    cd ~/Workspace/notes/
    set file_to_open (
        echo (
            fd | devicon-lookup | \
            fzf --preview="bat --color=always --line-range :100 (echo {} | cut -d' ' -f2-)" \
                --preview-window=right:90% \
                --height=100% --print-query | \
            tail -1
        ) | cut -d' ' -f2-
    )
    if string length -q -- "$file_to_open"
        nvim $file_to_open
    end

    cd $current_dir
end
