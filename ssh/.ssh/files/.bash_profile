#!/bin/bash

source ~/.bashrc

export PATH=$HOME/.local/bin:$PATH

# Open fish automatically after logging in to a server
if [ -f "$HOME"/.local/bin/fish ]; then
  exec "$HOME"/.local/bin/fish
fi
