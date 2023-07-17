#!/bin/bash

text=$(</dev/stdin)
hash=$(echo "$text" | md5sum | awk '{ print $1 }')

file=/tmp/.tmux-last-copy-selection
if test -f $file; then
  last=$(cat $file)
else
  last=""
fi

# Only send text to clipboard if the selected text is different than the last one. This
# is needed to avoid overriding clipboard from other applications.
if test "$hash" != "$last"; then
  echo "$text" | pbcopy
  echo "$hash" > $file
fi
