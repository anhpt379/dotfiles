#!/bin/bash

source ~/.bashrc

# Auto-start tmux. Lives here (not just in .zprofile) because bash is
# the actual login shell on most remotes — the zsh handoff below is
# non-login on purpose, so .zprofile won't fire from it.
if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX" ]; then
  tmux -u attach || tmux -u new
fi

# Hand off to zsh when available. Non-login + --no-globalrcs so the
# bash login's /etc/profile work is not redone:
#   - login zsh would run /etc/zprofile, which sources /etc/profile.
#   - any interactive zsh (login or not) runs /etc/zshrc, which on
#     Fedora-family systems loops over /etc/profile.d/*.sh itself.
# .zshrc is self-contained, so dropping the global rc files is safe.
if command -v zsh >/dev/null 2>&1; then
  exec zsh --no-globalrcs
fi

exec /bin/bash
