#!/bin/bash

source ~/.bashrc

if test -x "$HOME/.local/bin/tmux"; then
  # Auto start tmux
  if test -z "$TMUX"; then
    "$HOME"/.local/bin/tmux -u attach -t panh || "$HOME"/.local/bin/tmux -u new -s panh
  fi
fi

# Open fish automatically after logging in to a server
if test -x "$HOME/.local/bin/fish"; then
  exec "$HOME"/.local/bin/fish
else

  # Pull the full dotfiles in background
  nohup bash -cx "
    cd .files/ &&
    export GIT_SSH_COMMAND='ssh -i /usr/local/etc/gitlab_ssh_key_dotfiles/id_rsa' &&
    git fetch --depth 1 origin master &&
    git checkout FETCH_HEAD &&
    rsync -a HOME/ ~/
    source ~/.bashrc
  " > /dev/null 2>&1 &

  exec /bin/bash
fi
