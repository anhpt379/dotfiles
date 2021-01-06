#!/bin/sh

if file -bL --mime "$@" | grep 'charset=binary'; then
  echo
  dirname=$(dirname "$1")
  filename=$(basename "$@")
  cd "$dirname" && exa -lha --color=always "$filename"
else
  bat --color=always --line-range=:300 "$@"
fi

