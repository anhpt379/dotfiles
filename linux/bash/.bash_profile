#!/bin/bash

# get the aliases and functions
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# User specific environment and startup programs
if [ -f /usr/bin/fish ]; then
  exec /usr/bin/fish
fi
