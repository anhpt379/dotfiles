function fzf_find -d "Find files and folders"
    set -l max_depth $argv[1]
    set -l max_results 1000
    set -l cmd (commandline -p)

    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -l fd_command "fd --color=always --max-results=$max_results --no-ignore --hidden --exclude='.git' . $dir"

    if test -n "$max_depth"
        set -a fd_command "--max-depth=$max_depth"
        set tiebreak "end"
    else
        set tiebreak "length"
    end

    if string match -q "cd*" $cmd
        set -a fd_command "--type=d"
    end

    set fd_results (eval $fd_command)
    if [ (count $fd_results) -eq $max_results ]
        echo ""
        echo (set_color 3BB0E0) Showing the current dir only...(set_color normal)
        set -a fd_command "--max-depth=1"
        set fd_results (eval $fd_command)
    end

    set -l result (printf "%s\n" $fd_results | devicon-lookup | fzf --ansi --exact +m -1 --tiebreak=$tiebreak --expect=enter --header=":: Press TAB to accept suggestion, ENTER to accept suggestion and run." --bind=tab:accept --preview="~/.config/fzf/preview.sh {}" --query "$fzf_query")

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
        if test -d "$result"
            commandline -it -- "/"
        else
            commandline -it -- " "
        end
    end
    commandline -f repaint
end
