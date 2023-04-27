#!/bin/bash

source ~/.bashrc

# Open fish automatically after logging in to a server
if [ -f "$HOME/.local/bin/fish-appimage/squashfs-root/usr/bin/fish" ]; then
  exec "$HOME"/.local/bin/fish-appimage/squashfs-root/usr/bin/fish
fi
