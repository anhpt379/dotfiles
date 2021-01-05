#!/bin/sh

if file -bL --mime "$@" | grep 'charset=binary'; then
  echo
  exa -lha --color=always "$@"
else
  bat --color=always --line-range=:300 "$@"
fi

