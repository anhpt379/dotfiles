function fzf_find -d "Find files and folders"
    set -l command (commandline)
    if string match -q -- "de *" $command
        set result (
            sudo docker ps --format '{{.Names}}\n{{.ID}}' \
            | fzf --select-1 --exit-0 --ansi \
                --bind=tab:accept \
                --expect=enter \
                --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop" \
                --prompt="DOCKER> " \
                --query=(echo $command | sed 's/^de//' | xargs)
        )
    else if string match --regex -q -- "^(ssh|sdb) *" $command; and test -f ~/.cache/servers.txt
        set result (
            cat ~/.cache/servers.txt \
            | awk '{ print " " $1 }' \
            | fzf --select-1 --exit-0 --ansi \
                --bind=tab:accept \
                --expect=enter \
                --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
                --prompt="> " \
                --query=(echo $command | cut -d' ' -f2-)
        )
    else
        set -l commandline (__fzf_parse_commandline)
        set dir $commandline[1]
        set -l fzf_query $commandline[2]
        set -l fzf_preview_command "preview $dir/{}"

        set -l fd_command "command fd --one-file-system --no-ignore --hidden --exclude='.git'"
        if string match -q -- "." $dir
            set -a fd_command "--strip-cwd-prefix $dir"
        else
            set -a fd_command ". $dir"
        end

        if begin string match -rq -- "^cd .*" $command
            or string match -rq -- "^j .+" $command
        end
            if string match -rq -- "/\$" $command
                set fd_depth 10
            else if string match -rq -- " \$" $command
                set fd_depth 1
            else
                return 1
            end

            set result (
                eval "$fd_command --max-depth=$fd_depth --type=directory --follow" \
                | sed "s|^$dir/||" \
                | dimdirname \
                | devicon add \
                | fzf --delimiter=\t --select-1 --exit-0 --ansi \
                    --bind=tab:accept \
                    --expect=enter \
                    --scheme=path \
                    --height=40% \
                    --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
                    --prompt="DIRECTORY> " \
                    --keep-right \
                    --preview="$fzf_preview_command" \
                    --query="$fzf_query" \
            )
        else if string match -rq -- "^j \$" $command
            set fzf_preview_command "preview {}"

            set result (
                zoxide query --list --score 2> /dev/null \
                | awk '{ print " " $2 }' \
                | fzf --delimiter=\t --select-1 --exit-0 --ansi \
                    --bind=tab:accept \
                    --expect=enter \
                    --scheme=path \
                    --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
                    --preview="$fzf_preview_command" \
                    --query=(echo $command | sed 's/^j//' | xargs)
            )
        else if begin
                string match -q -- "ls *" $command
                or string match -q -- "ll *" $command
                or string match -q -- "lla *" $command
                or string match -q -- "rm -r*" $command
                or string match -q -- "scp -r *" $command
                or string match -q -- "mkdir *" $command
                or string match -q -- "du *" $command
                or string match -q -- "git -C*" $command
                or string match -q -- "cat *" $command
                or string match -q -- "tac *" $command
                or string match -q -- "less *" $command
                or string match -q -- "head *" $command
                or string match -q -- "tail *" $command
                or string match -q -- "view *" $command
                or string match -q -- "vim *" $command
                or string match -q -- "nvim *" $command
                or string match -q -- "nv *" $command
                or string match -q -- "rm -f*" $command
                or string match -q -- "chmod +x *" $command
                or string match -q -- "wc *" $command
                or string match -q -- "md5sum *" $command
                or string match -q -- "sed *" $command
                or string match -q -- "scp *" $command
                or string match -q -- "bash *" $command
                or string match -q -- "python *" $command
                or string match -q -- "source *" $command
                or string match -q -- "./*" $command
            end

            # Only trigger if user hasn't typed anything, or the path ends with a `/`
            if string match -rq -- "/\$" $command
                set -a fd_command "--max-depth=10"
            else if string match -rq -- " \$" $command
                set -a fd_command "--max-depth=1"
            else
                return 1
            end

            if begin
                    string match -q -- "rm -r*" $command
                    or string match -q -- "scp -r *" $command
                    or string match -q -- "mkdir *" $command
                    or string match -q -- "du *" $command
                    or string match -q -- "git -C *" $command
                end
                set -a fd_command "--type=directory"

            else if begin
                    string match -q -- "cat *" $command
                    or string match -q -- "tac *" $command
                    or string match -q -- "less *" $command
                    or string match -q -- "head *" $command
                    or string match -q -- "tail *" $command
                    or string match -q -- "view *" $command
                    or string match -q -- "vim *" $command
                    or string match -q -- "nvim *" $command
                    or string match -q -- "nv *" $command
                    or string match -q -- "rm -f*" $command
                    or string match -q -- "chmod +x *" $command
                    or string match -q -- "wc *" $command
                    or string match -q -- "md5sum *" $command
                    or string match -q -- "sed *" $command
                    or string match -q -- "scp *" $command
                    or string match -q -- "bash *" $command
                    or string match -q -- "python *" $command
                    or string match -q -- "source *" $command
                    or string match -q -- "./*" $command
                end
                set -a fd_command "--type=file"
            else
                # ls/ll/lla
                # look for both files & directories
            end

            # Cancel early if it takes too long
            set files (eval timeout 0.05 $fd_command)
            if test $status -eq 124 # timed out
                commandline -f repaint
                return 1
            end
            if test -z "$files"
                return
            end
            set result (
                printf %s\n $files \
                | sed "s|^$dir/||" \
                | dimdirname \
                | devicon add \
                | fzf --delimiter=\t --select-1 --exit-0 --ansi \
                    --expect=enter \
                    --scheme=path \
                    --height=40% \
                    --keep-right \
                    --header="$(tput setaf 1)TAB$(tput sgr0) to select, $(tput setaf 1)ENTER$(tput sgr0) to run, $(tput setaf 1)CTRL-[$(tput sgr0) to stop, $(tput setaf 1)CTRL-/$(tput sgr0) to toggle preview" \
                    --preview="$fzf_preview_command" \
                    --query="$fzf_query" \
            )

        else
            return 1
        end
    end

    if test $status -ne 0
        commandline -f repaint
        return
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

    if set -q dir; and not string match -q -- "/*" $result; and not string match -rq -- " \$" $command
        set result "$dir/$result"
    end

    if string match -q -- "* *" $command
        commandline -it -- $result
    else
        commandline -- $result
    end
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
            set fzf_query (string replace "$dir/" -- '' "$commandline")
        end
    end

    echo $dir
    echo $fzf_query
end


function __fzf_get_dir -d 'Find the longest existing filepath from input string'
    set dir $argv

    if not string match -qr -- '.*/$' $dir
        set dir (dirname -- "$dir")
    end

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
