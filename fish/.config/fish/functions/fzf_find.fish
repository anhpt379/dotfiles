function fzf_find -d "Find files and folders"
    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -l result (fd --hidden --exclude '.git' . $dir | devicon-lookup | fzf --expect=enter --header=":: Press TAB to accept suggestion, ENTER to accept suggestion and run." --bind=tab:accept --query "$fzf_query")

    if test -z "$result"
        commandline -f repaint
        return
    else
        commandline -t ""
    end

    set -l key (echo $result | cut -d' ' -f1)
    set -l result (echo $result | cut -d' ' -f3-)
    if test "$key" = "enter"
        commandline -it -- (string escape $result)
        commandline -f execute
    else
        commandline -it -- (string escape $result)
        commandline -it -- " "
    end
    commandline -f repaint
end
