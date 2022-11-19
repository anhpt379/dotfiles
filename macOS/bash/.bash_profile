#!/bin/bash

# ssh to the VM or run fish automatically
if test -f "/opt/homebrew/bin/limactl" && (/opt/homebrew/bin/limactl list | grep -q Running); then
  lima_ssh=$(/opt/homebrew/bin/limactl show-ssh fedora | sed 's/ lima-.*$/ lima/')
  kitty_ssh="kitty +kitten $lima_ssh"
  if ! eval "${kitty_ssh}"; then
    clear
    echo "SSH: Connection to the Fedora VM has been closed."
  fi
fi

if test -f "/opt/homebrew/bin/fish"; then
  /opt/homebrew/bin/fish
fi
