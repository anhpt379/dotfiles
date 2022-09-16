#!/bin/bash

# ssh to the VM or run fish automatically
if test -f "/opt/homebrew/bin/limactl" && (/opt/homebrew/bin/limactl list | grep -q Running); then
  lima_ssh=$(/opt/homebrew/bin/limactl show-ssh fedora)
  kitty_ssh="kitty +kitten $lima_ssh"
  eval ${kitty_ssh}
fi

if test -f "/opt/homebrew/bin/fish"; then
  /opt/homebrew/bin/fish
fi
