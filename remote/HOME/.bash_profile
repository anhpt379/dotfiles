#!/bin/bash

# Prefer zsh as the login shell when it's available.
if command -v zsh >/dev/null 2>&1; then
  exec zsh -l
fi

source ~/.bashrc

if which tmux &>/dev/null; then
  # Auto start tmux
  if test -z "$TMUX"; then
    tmux -u attach || tmux -u new
  fi
fi

exec /bin/bash
