#!/usr/bin/env bash

path=$(echo $1 | awk '{ print $2 }')

if [[ -d $path ]]; then
  echo "Directory: $(tput bold)$path"

  # preview directory contents with `exa`
  exa --color always -la --group-directories-first "$path"
elif [[ -f $path ]]; then
  # preview file contents with `bat`
  bat --color always --paging never "$path"
fi

