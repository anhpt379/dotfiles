function fzf_complete
    set -l command (commandline --cut-at-cursor)

    fzf_find >/dev/null
    if test $status -ne 1
        return
    end

    # Fallback to the default suggestion
    commandline -f complete
end
