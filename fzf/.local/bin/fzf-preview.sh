#!/usr/bin/env bash

# Remove the devicon
path=$(echo "$1" | devicon remove)

if echo "$path" | grep -P '\t'; then
  exit 0
fi

if [[ -d $path ]]; then
  echo "Directory: $(tput bold)$path"
  echo

  # preview directory contents with `exa`
  exa --color always -la --group-directories-first "$path"
else
  if file -bL --mime "$path" | grep -q 'charset=binary'; then
    # show file info if it's a binary file
    dirname=$(dirname "$path")
    filename=$(basename "$path")
    cd "$dirname" && exa -lha --color=always "$filename"
  else
    # preview file contents with `bat`
    bat --color=always --line-range=:300 "$path"
  fi
fi
