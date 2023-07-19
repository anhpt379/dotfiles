function magic_enter
    set -l command $(commandline)

    if test -z "$command"
        scroll_up
    end

    commandline -f execute
end
