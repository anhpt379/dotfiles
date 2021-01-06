#!/usr/bin/env bash

# Remove the devicon
path=$(echo "$1" | devicon remove)

if [[ -d $path ]]; then
  echo "Directory: $(tput bold)$path"

  # preview directory contents with `exa`
  exa --color always -la --group-directories-first "$path"
else
  if file -bL --mime "$path" | grep 'charset=binary'; then
    # show file info if it's a binary file
    echo
    dirname=$(dirname "$path")
    filename=$(basename "$path")
    cd "$dirname" && exa -lha --color=always "$filename"
  else
    # preview file contents with `bat`
    bat --color=always --line-range=:300 "$path"
  fi
fi
