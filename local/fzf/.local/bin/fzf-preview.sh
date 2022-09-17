#!/usr/bin/env bash

# Remove the devicon
name=$(echo "$1" | devicon remove)

if [[ -d $name ]]; then
  echo "Directory: $(tput bold)$name"
  echo

  # preview directory contents with `exa`
  command ls --color=always --group-directories-first -lhAvF "$name"
elif [[ -f $name ]]; then
  if file -bL --mime "$name" | grep -q 'charset=binary'; then
    # show file info if it's a binary file
    dirname=$(dirname "$name")
    filename=$(basename "$name")
    cd "$dirname" && command ls -lh --color=always "$filename"
  else
    # since nvimpager is slow for large files, but I like its highlighting, so
    # let's use nvimpager only in case we think it might be possible for the
    # highlighting to work (which means the file has an extension, and that
    # extension is not `.txt`)
    if echo "$name" | grep -q '\.txt$'; then
      command cat "$name"
    elif basename "$name" | grep -qF '.'; then
      # Tell nvimpager (again) where nvim is
      # Somehow on remote this variable is changed to another value (it looks
      # like this: `NVIM=/tmp/nvimQPBuJM/0`), I couldn't figure out why, so
      # this workaround will fix no preview for fzf in vim on remote servers.
      export NVIM=~/.local/bin/nvim-appimage/squashfs-root/usr/bin/nvim
      nvimpager -c "$name"
    else
      command cat "$name"
    fi
  fi
elif command -v "$name"; then
  type "$name"
fi
