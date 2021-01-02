function fzf_find -d "Find files and folders"
    set -l max_depth $argv[1]
    set -l max_results 1000
    set -l cmd (commandline -p)

    set -l commandline (__fzf_parse_commandline)
    set -l dir $commandline[1]
    set -l fzf_query $commandline[2]

    set -l fd_command "fd --color=always --max-results=$max_results --no-ignore --hidden --follow --exclude='.git' . $dir"

    if test -n "$max_depth"
        set -a fd_command "--max-depth=$max_depth"
        if test "$dir" = "."
            set tiebreak "begin"
        else
            set tiebreak "end"
        end
    else
        set tiebreak "end"
    end

    if string match -q "cd*" $cmd
        set -a fd_command "--type=d"
    end

    set fd_results (eval $fd_command)
    if [ (count $fd_results) -eq $max_results ]
        echo ""
        echo (set_color 3BB0E0)Too many results. Showing the current dir only...(set_color normal)
        set -a fd_command "--max-depth=1"
        set fd_results (eval $fd_command)
    end

    if [ (count $fd_results) -eq 0 ]
        commandline -it -- " "
        return
    end

    set -l result (printf "%s\n" $fd_results | devicon-lookup | fzf --ansi --exact +m -1 --tiebreak=$tiebreak --expect=enter --header="(Press TAB to accept, ENTER to accept and run)" --bind=tab:accept --preview="~/.config/fzf/preview.sh {}" --query "$fzf_query")

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
            commandline -it -- ""
        end
    end
    commandline -f repaint
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
