function fzf_complete
    set -l command (commandline --cut-at-cursor)
    # set -l keyword (commandline -ct)

    # Trigger fzf_find instead if there're directories in the suggestion
    if complete -C "$command" | grep "/\$" >/dev/null
        fzf_find >/dev/null
        if test $status -ne 1
            return
        end
    end

    # Fallback to the default suggestion
    commandline -f complete
end
