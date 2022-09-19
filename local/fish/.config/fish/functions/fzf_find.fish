function fzf_find -d "Find files and folders"
    set -l command (commandline)
    if string match -q -- "ssh*" $command
        set result (
            cat ~/.cache/servers.txt \
            | awk '{ print " " $1 }' \
            | fzf --select-1 --exit-0 --ansi \
                --bind=tab:accept \
                --expect=enter \
                --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
                --prompt="SSH> " \
                --query=(echo $command | sed 's/^ssh//' | xargs)
        )
    else
        set -l commandline (__fzf_parse_commandline)
        set -l dir $commandline[1]
        set -l fzf_query $commandline[2]

        set -l fd_command "fd --no-ignore --hidden --exclude='.git'"
        if string match -q -- "." $dir
            set -a fd_command "--strip-cwd-prefix $dir"
        else
            set -a fd_command ". $dir"
        end

        if string match -q -- "cd*" $command
            set result (
                eval "$fd_command --type=directory --type=symlink" \
                | devicon add \
                | fzf --delimiter=\t --select-1 --exit-0 --ansi \
                    --bind=tab:accept \
                    --expect=enter \
                    --tiebreak=chunk \
                    --height=60% \
                    --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
                    --prompt="DIRECTORY> " \
                    --preview="$FZF_PREVIEW_COMMAND" \
                    --query="$fzf_query" \
            )
        else if string match -q -- "j*" $command
            # auto remove directories that no longer exist
            z --clean > /dev/null 2>&1

            set result (
                __z --recent --list 2> /dev/null \
                | awk '{ print " " $2 }' \
                | fzf --delimiter=\t --select-1 --exit-0 --ansi \
                    --bind=tab:accept \
                    --expect=enter \
                    --tiebreak=chunk \
                    --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
                    --preview="$FZF_PREVIEW_COMMAND" \
                    --query=(echo $command | sed 's/^j//' | xargs)
            )
        else
            set files (eval timeout 0.05 $fd_command)
            if test $status -eq 124  # timed out
                echo -e "\nIt took too long to list files, canceling..."
                commandline -f repaint
                return 1
            end
            if test -z "$files"
                return
            end
            set result (
                printf %s\n $files \
                | devicon add \
                | fzf --delimiter=\t --select-1 --exit-0 --ansi \
                    --expect=enter \
                    --tiebreak=chunk \
                    --height=60% \
                    --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
                    --preview="$FZF_PREVIEW_COMMAND" \
                    --query="$fzf_query" \
            )
        end
    end

    if not string match -q -- "* *" $command
        commandline -it -- " "
    end

    if test -z "$result"
        commandline -f repaint
        return
    else
        commandline -t ""
    end

    set -l key (echo $result | cut -d' ' -f1)
    set -l result (echo $result | cut -d' ' -f2- | devicon remove)
    commandline -it -- (string escape $result)
    commandline -f repaint
    if test "$key" = enter
        commandline -f execute
    end
end


# Copied from https://github.com/junegunn/fzf/blob/fd8858f8c93e38d50f00cd21430e21d89e2f9399/shell/key-bindings.fish#L119-L159
function __fzf_parse_commandline -d 'Parse the current command line token and return split of existing filepath and rest of token'
    # eval is used to do shell expansion on paths
    set -l commandline (eval "printf '%s' "(commandline -t))

    if [ -z $commandline ]
        # Default to current directory with no --query
        set dir '.'
        set fzf_query ''
    else
        set dir (__fzf_get_dir $commandline)

        if [ "$dir" = "." -a (string sub -l 1 -- $commandline) != '.' ]
            # if $dir is "." but commandline is not a relative path, this means no file path found
            set fzf_query $commandline
        else
            # Also remove trailing slash after dir, to "split" input properly
            set fzf_query (string replace -r "^$dir/?" -- '' "$commandline")
        end
    end

    echo $dir
    echo $fzf_query
end


function __fzf_get_dir -d 'Find the longest existing filepath from input string'
    set dir $argv

    # Strip all trailing slashes. Ignore if $dir is root dir (/)
    if [ (string length -- $dir) -gt 1 ]
        set dir (string replace -r '/*$' -- '' $dir)
    end

    # Iteratively check if dir exists and strip tail end of path
    while [ ! -d "$dir" ]
        # If path is absolute, this can keep going until ends up at /
        # If path is relative, this can keep going until entire input is consumed, dirname returns "."
        set dir (dirname -- "$dir")
    end

    echo $dir
end
