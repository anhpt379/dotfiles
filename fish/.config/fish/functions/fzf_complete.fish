function fzf_complete
    set -l cmdline (commandline)
    set -l current_word (commandline -ct)

    # Color descriptions manually
    set result (
        begin
            complete -C "$cmdline." | grep -Fv '/./' | grep -Fv '/../' | grep -Fv './' | grep -Fv '../'
            complete -C "$cmdline"
        end \
        | sort | uniq \
        | string replace -r \t'(.*)$' \t(set_color $fish_pager_color_description)'$1'(set_color normal) \
        | devicon add \
        | fzf --delimiter=\t --select-1 --exit-0 --ansi \
              --bind=tab:accept \
              --expect=enter \
              --tiebreak=begin \
              --header="(Press TAB to accept, ENTER to accept and run)" \
              --preview="~/.local/bin/fzf-preview.sh {}" \
              --query "$current_word" \
    )

    # Split key & result
    set key (echo $result | cut -d' ' -f1)
    set result (echo $result | cut -d' ' -f2- | devicon remove)

    # Remove description
    set result (string replace -r \t'.*' '' -- $result)

    if test "$result" = ""
        commandline -it -- ""
        commandline -f repaint
    else
        commandline -rt -- "$result"
        commandline -f repaint
        if test "$key" = enter
            commandline -f execute
        end
    end
end
