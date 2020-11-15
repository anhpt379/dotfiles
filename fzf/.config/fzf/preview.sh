#!/usr/bin/env bash

# Remove the devicon
path=$(echo "$1" | awk '{ print $2 }')

if [[ -d $path ]]; then
  echo "Directory: $(tput bold)$path"

  # preview directory contents with `exa`
  exa --color always -la --group-directories-first "$path"
else
  # preview file contents with `bat`
  bat --color=always "$path"
fi

