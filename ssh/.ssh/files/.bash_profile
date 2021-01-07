#!/bin/bash

source ~/.bashrc

export PATH=$HOME/.local/bin:$PATH

# Open fish automatically after logging in to a server
sleep 1
exec "$HOME"/.local/bin/fish
