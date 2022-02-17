#!/bin/bash

source ~/.bashrc

# Open fish automatically after logging in to a server
if [ -f "$HOME"/.rsync-done ] && [ -f "$HOME/.local/bin/fish" ]; then
  exec "$HOME"/.local/bin/fish
fi
