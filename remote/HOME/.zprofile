#!/usr/bin/env zsh
# Auto-start tmux on login. PATH needs ~/.local/bin since tmux lives
# there on most remotes; .zshrc sets the same PATH but runs after this
# file, so we set it here too.
typeset -U path PATH
path=($HOME/.local/bin /usr/sbin $path)

if (( ${+commands[tmux]} )) && [[ -z $TMUX ]]; then
  tmux -u attach || tmux -u new
fi
