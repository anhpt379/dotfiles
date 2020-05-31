function gl --description "Git browse commits"
    set -l log_line_to_hash "echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
    set -l view_commit      "$log_line_to_hash | xargs -I % sh -c 'git show --color=always %'"
    set -l preview_commit   "$log_line_to_hash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy | less --tabs=4 -RX'"
    set -l copy_commit_hash "$log_line_to_hash | tr -d '\n' | pbcopy"

    set open_in_browser "$log_line_to_hash | xargs -I % sh -c 'open https://\$(git config remote.origin.url | sed \'s/^git@//\' | sed \'s/\.git\$//\' | sed \'s/:/\//\')/commit/%'"

    git log -5000 --no-merges --color=always --format="%C(auto)%h%d %C(reset)%s %C(#555555)(%aN - %cr)" | \
        fzf --no-sort --reverse --tiebreak=index --no-multi --ansi --height=100% \
            --preview="$preview_commit" \
            --header="ENTER to view, CTRL-Y to copy hash, CTRL-O to open in browser, ESC to exit" \
            --bind "enter:execute:$view_commit" \
            --bind "ctrl-y:execute-silent($copy_commit_hash)+abort" \
            --bind "ctrl-o:execute-silent($open_in_browser)+abort"
end
