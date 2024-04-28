function fzf_history -d "Show command history"
    set -l result (
        history -z \
        | fzf --expect=enter \
              --tiebreak=index \
              --scheme=history \
              --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop" \
              --prompt="HISTORY> " \
              --bind=tab:accept \
              --read0 \
              --query=^(commandline)
    )
    if test $status -ne 0
        commandline -f repaint
        return
    end

    set -l key (echo $result | cut -d' ' -f1)
    set -l result (echo $result | cut -d' ' -f2-)
    if test "$key" = enter
        commandline -- $result
        commandline -f repaint
        commandline -f execute
    else if test -n $result
        commandline -- $result
        commandline -it -- " "
        commandline -f repaint
    else
        commandline -f repaint
    end
end
