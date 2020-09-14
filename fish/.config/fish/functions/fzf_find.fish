function fzf_find -d "Find files and folders"
    set -l cmd (commandline -p)
    if string match -q "cd*" $cmd
        set type "d"
    else
        set type "f"
    end

    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -l result (fd --no-ignore --hidden --exclude '.git' --type $type . $dir | devicon-lookup | fzf --expect=enter --header=":: Press TAB to accept suggestion, ENTER to accept suggestion and run." --bind=tab:accept --preview="~/.config/fzf/preview.sh {}" --query "$fzf_query")

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
