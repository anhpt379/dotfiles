function fzf_complete
    set -l command (commandline --cut-at-cursor)
    set -l keyword (commandline -ct)

    # Color descriptions manually
    set -l result (
        begin
            complete -C "$command." | grep -Fv '/./' | grep -Fv '/../' | grep -Fv './' | grep -Fv '../'
            complete -C "$command"
        end \
        | sort | uniq \
        | string replace -r \t'(.*)$' \t$(tput setaf 8)'$1'$(tput sgr0) \
        | fzf --delimiter=\t --select-1 --exit-0 --ansi \
              --expect=enter \
              --expect=tab \
              --expect=esc \
              --no-height \
              --tiebreak=chunk \
              --scheme=path \
              --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-C$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
              --preview="$FZF_PREVIEW_COMMAND" \
              --query "$keyword" \
    )

    # Split key & result
    set -l key (echo $result | cut -d' ' -f1)
    set -l result (echo $result | cut -d' ' -f2-)

    # Remove description
    set -l result (string replace -r \t'.*' '' -- $result)

    if test "$result" = ""
        commandline -it -- ""
        commandline -f repaint
    else
        if string match -q -- "*/" $result
            commandline -rt -- (string replace --all " " "\\ " -- $result)
            if test "$key" = tab || test $key = ""
                fzf_complete
            end
        else
            commandline -rt -- (string replace --all " " "\\ " -- $result)" "
        end
        commandline -f repaint

        if test "$key" = enter
            commandline -f execute
        end
    end
end
