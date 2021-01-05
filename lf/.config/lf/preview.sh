#!/bin/sh

if file -bL --mime "$@" | grep 'charset=binary'; then
  echo
  ls -lha "$@"
else
  bat --color=always --line-range=:300 "$@"
fi

