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
  command ls --color=always --group-directories-first -lhAvF "$path"
else
  if file -bL --mime "$path" | grep -q 'charset=binary'; then
    # show file info if it's a binary file
    dirname=$(dirname "$path")
    filename=$(basename "$path")
    cd "$dirname" && command ls -lh --color=always "$filename"
  else
    # since nvimpager is slow for large files, but I like its highlighting, so
    # let's use nvimpager only in case we think it might be possible for the
    # highlighting to work (which means the file has an extension, and that
    # extension is not `.txt`)
    if echo "$path" | grep -q '\.txt$'; then
      command cat "$path"
    elif basename "$path" | grep -qF '.'; then
      # Tell nvimpager (again) where nvim is
      # Somehow on remote this variable is changed to another value (it looks
      # like this: `NVIM=/tmp/nvimQPBuJM/0`), I couldn't figure out why, so
      # this workaround will fix no preview for fzf in vim on remote servers.
      export NVIM=~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim
      nvimpager -c "$path"
    else
      command cat "$path"
    fi
  fi
fi
