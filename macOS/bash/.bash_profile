#!/bin/bash

# ssh to the VM or run fish automatically
if test -f "/opt/homebrew/bin/limactl" && (/opt/homebrew/bin/limactl list | grep -q Running); then
  lima_ssh=$(/opt/homebrew/bin/limactl show-ssh fedora | sed 's/ lima-.*$/ lima/')
  if test "$(date +%u)" -gt 5; then
    # Use `kitty +kitten ssh` on weekend only, since it's slower than the
    # regular ssh (we have to run `kitty +kitten ssh` sometimes to sync shell
    # integration code to the VM)
    ssh_command="kitty +kitten $lima_ssh"
  else
    ssh_command=$lima_ssh
  fi
  if ! eval "${ssh_command}"; then
    clear
    echo "SSH: Connection to the Fedora VM has been closed."
  fi
fi

if test -f "/opt/homebrew/bin/fish"; then
  /opt/homebrew/bin/fish
fi
