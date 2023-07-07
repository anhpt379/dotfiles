#!/bin/bash

for pid in $(pidof -x tmux-set-mouse-off.sh); do
  if test "$pid" -ne $$; then
    echo "Process is already running with PID $pid"
    exit
  fi
done

while true; do
  if test "$(tmux show mouse)" = "mouse on"; then
    tmux set -w mouse off
  fi
  sleep 0.5
done
