#!/bin/bash

source ~/.bashrc

if test -x "$HOME/.local/bin/tmux"; then
  # Auto start tmux
  if test -z "$TMUX"; then
    "$HOME"/.local/bin/tmux -u attach -t panh || "$HOME"/.local/bin/tmux -u new -s panh
  fi
fi

# Open fish automatically after logging in to a server
if test -x "$HOME/.local/bin/fish"; then
  exec "$HOME"/.local/bin/fish
fi
