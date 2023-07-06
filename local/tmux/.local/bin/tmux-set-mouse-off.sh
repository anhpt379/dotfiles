#!/bin/bash

if tmux show mouse | grep -q on; then
  tmux set -w mouse off
fi
