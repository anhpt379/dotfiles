function gl --description "fzf git log"
    git rev-parse HEAD >/dev/null; or return

    set log_line_to_hash "echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
    set view_commit "git show --color=always ($log_line_to_hash)"
    set preview_commit "git show --color=always ($log_line_to_hash) | diff-so-fancy | less --tabs=4 -RX"
    set copy_commit_hash "$log_line_to_hash | tr -d '\n' | pbcopy"
    set open_in_browser "$log_line_to_hash | xargs -I % sh -c 'open https://\$(git config remote.origin.url | sed \'s/^git@//\' | sed \'s/\.git\$//\' | sed \'s/:/\//\')/commit/%'"

    set argv_count (count $argv)
    set cmd_name $_

    if [ $cmd_name = "gl" ]
        if [ $argv_count -eq 1 ]
            set args "-- $argv[1]"
        end
    else
        if [ $argv_count -eq 1 ]
            set args "-i -S$argv[1]"
        else if [ $argv_count -eq 2 ]
            set args "-i -S$argv[1] -- $argv[2]"
        end
    end
    set git_cmd "git log -5000 \
                    --no-merges \
                    --color=always \
                    --format='%C(green)%h %C(reset)%s %C(#555555)%b(%aN - %cr)' \
                    $args"
    eval $git_cmd \
        | tr "\n" " " \
        | sed -E "s/\\x1b\\[32m[a-f0-9]{7,}+/\\n&/2g" \
        | fzf --no-mouse --reverse --tiebreak=index --no-multi --ansi --height=100% \
        --preview="$preview_commit" \
        --header=" CTRL-S to toggle sort, CTRL-Y to copy hash, CTRL-O to open in browser, CTRL-P to push" \
        --bind="enter:execute/$view_commit/+abort" \
        --bind="ctrl-y:execute-silent/$copy_commit_hash/+abort" \
        --bind="ctrl-o:execute-silent/$open_in_browser/+abort" \
        --bind="ctrl-p:execute/git push --force-with-lease/+abort" \
        --bind="ctrl-s:toggle-sort"
end
