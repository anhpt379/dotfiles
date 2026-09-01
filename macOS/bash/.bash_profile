#!/bin/bash

# Only drop into fish for interactive shells — non-interactive bash
# (Claude Code, scripts, ssh commands) must never be hijacked.
if [[ -z "$CLAUDECODE" ]] && [[ $- == *i* ]] && test -f "/opt/homebrew/bin/fish"; then
  exec /opt/homebrew/bin/fish
fi
