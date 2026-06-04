#!/bin/bash

source ~/.bashrc

if which tmux &>/dev/null; then
  # Auto start tmux
  if test -z "$TMUX"; then
    tmux -u attach || tmux -u new
  fi
fi

exec /bin/bash
