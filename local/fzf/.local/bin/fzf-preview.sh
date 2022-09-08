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
    # since nvimpager is slow for large files, but I like its highlighting, so
    # let's use nvimpager only in case we think it might be possible for the
    # highlighting to work (which means the file has an extension, and that
    # extension is not `.txt`)
    if echo "$path" | grep -q '\.txt$'; then
      command cat "$path"
    elif basename "$path" | grep -qF '.'; then
      nvimpager -c "$path"
    else
      command cat "$path"
    fi
  fi
fi
