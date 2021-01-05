function fzf_complete
    set -l cmdline (commandline)
    set -l current_word (commandline -ct)

    # Color descriptions manually
    set result (
        begin
            complete -C "$cmdline." | grep -Fv '/./' | grep -Fv '/../' | grep -Fv './' | grep -Fv '../'
            complete -C "$cmdline"
        end \
        | string replace -r \t'(.*)$' \t(set_color $fish_pager_color_description)'$1'(set_color normal) \
        | ~/.config/fzf/devicon-lookup.py \
        | fzf --delimiter=\t --select-1 --exit-0 --exact --ansi \
              --bind=tab:accept \
              --expect=enter \
              --tiebreak=begin \
              --header="(Press TAB to accept, ENTER to accept and run)" \
              --preview="~/.config/fzf/preview.sh {}" \
              --query "$current_word" \
    )

    # Split key & result
    set key (echo $result | cut -d' ' -f1)
    set result (echo $result | cut -d' ' -f3-)

    # Remove description
    set result (string replace -r \t'.*' '' -- $result)

    if test "$result" = ""
        commandline -it -- " "
        return
    else
        commandline -rt -- "$result"
        if test "$key" = enter
            commandline -f execute
        end
        commandline -f repaint
    end
end
