function fzf_history -d "Show command history"
    set -l result (
        history -z \
        | fzf --tiebreak=index \
              --expect=enter \
              --header="(Press TAB to accept, ENTER to accept and run)" \
              --bind=tab:accept \
              --read0 \
              --query=(commandline)
    )

    set -l key (echo $result | cut -d' ' -f1)
    set -l result (echo $result | cut -d' ' -f2-)
    if test "$key" = enter
        commandline -- $result
        commandline -f execute
    else
        commandline -- $result
        commandline -it -- " "
    end
    commandline -f repaint
end