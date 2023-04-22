#!/usr/bin/env bash
set -eu

if [ "$#" -eq 3 ]; then
  INPUT_LINE_NUMBER=${1:-0}
  CURSOR_LINE=${2:-1}
  CURSOR_COLUMN=${3:-1}
  ((CURSOR_COLUMN+=2))
  AUTOCMD_TERMCLOSE_CMD="call cursor(max([0,${INPUT_LINE_NUMBER}-1])+${CURSOR_LINE}, ${CURSOR_COLUMN})"
else
  AUTOCMD_TERMCLOSE_CMD="normal G"
fi

exec /opt/homebrew/bin/nvim \
  -u NONE \
  -c "map <silent> q :<C-u>qa!<CR>" \
  -c "set shell=bash scrollback=100000 laststatus=0 clipboard+=unnamedplus nowrap incsearch ignorecase smartcase" \
  -c "autocmd TermEnter * stopinsert" \
  -c "autocmd TermClose * ${AUTOCMD_TERMCLOSE_CMD}" \
  -c "autocmd VimEnter * normal G" \
  -c "nmap p ? \\\|^\[.*\]<CR>" \
  -c "nmap <CR>  :nohlsearch<CR> | nmap <ESC> :nohlsearch<CR>" \
  -c "nmap H zH | nmap L zL | nmap J <C-e> | nmap K <C-y> | nmap <ScrollWheelLeft> <nop> | nmap <ScrollWheelRight> <nop>" \
  -c "nmap a <nop> | nmap i <nop>" \
  -c "silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer -"
