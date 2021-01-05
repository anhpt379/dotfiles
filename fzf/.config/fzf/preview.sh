#!/usr/bin/env bash

# Remove the devicon
path=$(echo "$1" | awk '{ print $2 }')

if [[ -d $path ]]; then
  echo "Directory: $(tput bold)$path"

  # preview directory contents with `exa`
  exa --color always -la --group-directories-first "$path"
else
  if file -bL --mime "$@" | grep 'charset=binary'; then
    # show file info if it's a binary file
    echo
    exa -lha --color=always "$path"
  else
    # preview file contents with `bat`
    bat --color=always --line-range=:300 "$path"
  fi
fi
