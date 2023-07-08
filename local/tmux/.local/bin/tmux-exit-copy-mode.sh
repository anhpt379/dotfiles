#!/bin/bash

if test -f /tmp/.tmux-exit-copy-mode; then
  tmux copy-mode -q
  rm -f /tmp/.tmux-exit-copy-mode
fi
