function fish_user_key_bindings --description "User key bindings for fish"
    # Key bindings
    bind ctrl-f accept-autosuggestion execute
    bind ctrl-z undo

    # Make Control+W (or Option+Delete) in fish works similar to vim. By default,
    # fish binds it to `backward-kill-path-component`, which doesn't respect the
    # `-` character in the middle of a word.
    bind ctrl-w backward-kill-bigword
    bind ctrl-delete kill-bigword

    bind alt-backspace backward-kill-word
    bind alt-delete kill-word

    # Use pageup/pagedown to jump between big words
    bind ctrl-k forward-bigword
    bind ctrl-j backward-bigword

    # Fix random command appears when pressing Option-N/P. This maps them to
    # Up/Down, to behave the same as Ctrl-N/P.
    bind ctrl-n down-or-search
    bind ctrl-p up-or-search

    # Ctrl-D to exit immediately (the default behavior is `delete-or-exit`, which
    # is annoying since I can't exit the shell in the middle of typing a command)
    bind ctrl-d exit

    # Edit and run the current command in vim
    bind ctrl-v edit_and_run_command_buffer

    # Fzf
    bind --erase ctrl-o
    bind tab fzf_complete
    bind ctrl-r fzf_history
end
