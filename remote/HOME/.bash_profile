#!/bin/bash

source ~/.bashrc

# Pull the full dotfiles in background
if test -f /usr/local/etc/gitlab_ssh_key_dotfiles/id_rsa; then
  nohup bash -c "
    cd .files/ &&
    export GIT_SSH_COMMAND='ssh -i /usr/local/etc/gitlab_ssh_key_dotfiles/id_rsa' &&
    git fetch --depth 1 origin master &&
    git checkout FETCH_HEAD &&
    rsync -av HOME/ ~/
    source ~/.bashrc
  " > ~/.dotfiles.log 2>&1 &
fi

if test -x "$HOME/.local/bin/tmux"; then
  # Auto start tmux
  if test -z "$TMUX"; then
    "$HOME"/.local/bin/tmux -u attach || "$HOME"/.local/bin/tmux -u new
  fi
fi

# Open fish automatically if it's there
if test -x "$HOME/.local/bin/fish"; then
  exec "$HOME"/.local/bin/fish
else
  exec /bin/bash
fi
