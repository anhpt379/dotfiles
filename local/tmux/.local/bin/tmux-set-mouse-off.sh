#!/bin/bash

if test "$(tmux show mouse)" = "mouse on"; then
  tmux set mouse off
fi
