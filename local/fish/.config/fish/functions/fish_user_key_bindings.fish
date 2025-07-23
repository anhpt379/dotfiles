function fish_user_key_bindings --description "User key bindings for fish"
    # Key bindings
    bind \cf accept-autosuggestion execute
    bind \cz undo

    # Make Control+W (or Option+Delete) in fish works similar to vim. By default,
    # fish binds it to `backward-kill-path-component`, which doesn't respect the
    # `-` character in the middle of a word.
    bind \cw backward-kill-bigword

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
    bind \cd exit

    # Edit and run the current command in vim
    bind \cv edit_and_run_command_buffer

    # Fzf
    bind --erase \co
    bind \t fzf_complete
    bind \cr fzf_history
end
