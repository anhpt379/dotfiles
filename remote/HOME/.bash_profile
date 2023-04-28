#!/bin/bash

source ~/.bashrc

# Auto start tmux
if test -z "$TMUX" && test -x /usr/bin/tmux; then
  /usr/bin/tmux attach -t panh || /usr/bin/tmux new -s panh
fi

# Open fish automatically after logging in to a server
if [ -f "$HOME/.local/bin/fish-appimage/squashfs-root/usr/bin/fish" ]; then
  exec "$HOME"/.local/bin/fish-appimage/squashfs-root/usr/bin/fish
fi
