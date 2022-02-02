#!/usr/bin/env fish

# ssh to vagrant automatically
if nc -z 127.0.0.1 2222
    ssh -p 2222 \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        -o LogLevel=ERROR \
        -o IdentitiesOnly=yes \
        -i ~/dotfiles/macOS/.vagrant/machines/default/virtualbox/private_key \
        vagrant@127.0.0.1
end

# Common aliases
alias ..    'cd ..'
alias ...   'cd ../..'
alias ....  'cd ../../..'
alias ..... 'cd ../../../..'

alias cmd 'command'

alias ls  'exa --group-directories-first'
alias la  'exa --group-directories-first -a'
alias ll  'exa --group-directories-first -l'
alias lla 'exa --group-directories-first -la'

# Key bindings
bind \cg accept-autosuggestion execute
bind \cz undo

# Delete big word with Ctrl+Backspace
bind \cH backward-kill-bigword

# Make reverse word delete work (using ctrl/option+delete)
bind \e\[3\;5~ kill-bigword
bind \e\[3\;3~ kill-word

# Use pageup/pagedown to jump between big words
bind \e\[5~ forward-bigword
bind \e\[6~ backward-bigword

# Fix random command appears when pressing Option-N/P. This maps them to
# Up/Down, to behave the same as Ctrl-N/P.
bind \en down-or-search
bind \ep up-or-search

# Ctrl-D to exit immediately (the default behavior is `delete-or-exit`, which
# is annoying since I can't exit the shell in the middle of typing a command)
bind \cd 'exit'

# Fix can't see `null` in jq output (also changed `false` to red, `true` to
# green)
set -gx JQ_COLORS '36:31:32:0;39:0;32:1;39:1;39'

# Custom fish color scheme
set -U fish_color_normal normal
set -U fish_color_command dcdfe4
set -U fish_color_quote ffcc66
set -U fish_color_redirection d3d0c8
set -U fish_color_end cc99cc
set -U fish_color_error dd3c69
set -U fish_color_param dcdfe4
set -U fish_color_comment ffcc66
set -U fish_color_match 6699cc
set -U fish_color_selection white --bold --background=brblack
set -U fish_color_search_match bryellow --background=brblack
set -U fish_color_history_current --bold
set -U fish_color_operator 6699cc
set -U fish_color_escape 66cccc
set -U fish_color_cwd green
set -U fish_color_cwd_root red
set -U fish_color_valid_path --bold
set -U fish_color_autosuggestion 747369
set -U fish_color_user brgreen
set -U fish_color_host normal
set -U fish_color_cancel -r
set -U fish_pager_color_completion normal
set -U fish_pager_color_description B3A06D yellow
set -U fish_pager_color_prefix white --bold --underline
set -U fish_pager_color_progress brwhite --background=cyan
