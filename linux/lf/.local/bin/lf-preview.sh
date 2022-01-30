#!/bin/sh
if file -bL --mime "$@" | grep -q 'charset=binary'; then
  dirname=$(dirname "$1")
  filename=$(basename "$1")
  cd "$dirname" && exa -lha --color=always "$filename"
else
  bat --color=always --line-range=:300 "$@"
fi
