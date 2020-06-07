function gl --description "Git browse commits"
  git rev-parse HEAD > /dev/null 2>&1 || return

  set -l log_line_to_hash "echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
  set -l view_commit      "git show --color=always ($log_line_to_hash)"
  set -l preview_commit   "git show --color=always ($log_line_to_hash) | diff-so-fancy | less --tabs=4 -RX"
  set -l copy_commit_hash "$log_line_to_hash | tr -d '\n' | pbcopy"

  set open_in_browser "$log_line_to_hash | xargs -I % sh -c 'open https://\$(git config remote.origin.url | sed \'s/^git@//\' | sed \'s/\.git\$//\' | sed \'s/:/\//\')/commit/%'"

  git log -5000 \
    --no-merges \
    --color=always \
    --format="%C(auto)%h %C(reset)%s %C(#555555)%b(%aN - %cr)" \
    | tr '\n' ' ' \
    | sed -E 's/[a-f0-9]{7,}+/\\n&/2g' \
    | fzf --no-mouse --reverse --tiebreak=index --no-multi --ansi --height=100% \
          --preview="$preview_commit" \
          --header=" CTRL-S to toggle sort, CTRL-Y to copy hash, CTRL-O to open in browser" \
          --bind="enter:execute/$view_commit/+abort" \
          --bind="ctrl-y:execute-silent/$copy_commit_hash/+abort" \
          --bind="ctrl-o:execute-silent/$open_in_browser/+abort" \
          --bind="ctrl-s:toggle-sort"
end
