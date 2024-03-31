#!/bin/bash

# ssh to the VM or run fish automatically
if test -f "/opt/homebrew/bin/limactl" && (/opt/homebrew/bin/limactl list | grep -q Running); then
  lima_ssh=$(/opt/homebrew/bin/limactl show-ssh fedora39 | sed 's/ lima-.*$/ lima/')
  ssh_command="$lima_ssh"
  if ! eval "${ssh_command}"; then
    clear
    echo "SSH: Connection to the Fedora VM has been closed."
  fi
fi

if test -f "/opt/homebrew/bin/fish"; then
  /opt/homebrew/bin/fish
fi
