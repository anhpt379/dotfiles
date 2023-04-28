#!/bin/bash

source ~/.bashrc

if test -x /usr/bin/tmux; then
  # Auto start tmux
  if test -z "$TMUX"; then
    /usr/bin/tmux -u attach -t panh || /usr/bin/tmux -u new -s panh
  fi
fi

# Open fish automatically after logging in to a server
if [ -f "$HOME/.local/bin/fish-appimage/squashfs-root/usr/bin/fish" ]; then
  exec "$HOME"/.local/bin/fish-appimage/squashfs-root/usr/bin/fish
fi
