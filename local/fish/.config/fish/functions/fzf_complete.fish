function fzf_complete
    set -l command (commandline --cut-at-cursor)

    # Trigger fzf_find instead if the command ends with a slash `/` or the command
    # starts with `ssh` or `j `
    if string match -rq -- "/\$" $command; or string match -q -- "ssh*" $command; or string match -q -- "j *" $command
        fzf_find >/dev/null
        if test $status -ne 1
            return
        end
    end

    # Fallback to the default suggestion
    commandline -f complete
end
