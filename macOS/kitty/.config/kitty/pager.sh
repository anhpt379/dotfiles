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
  -c "set shell=bash termguicolors scrollback=100000 laststatus=0 clipboard+=unnamedplus nowrap incsearch ignorecase smartcase mousescroll=ver:1,hor:0" \
  -c "highlight Visual cterm=NONE ctermfg=0 ctermbg=12 gui=NONE guifg=#000000 guibg=#28c9ff | highlight NonText ctermfg=59 gui=NONE guifg=#555555 | highlight Search cterm=NONE ctermfg=0 ctermbg=214 gui=NONE guifg=#000000 guibg=#ffcc66 | highlight IncSearch cterm=NONE ctermfg=0 ctermbg=214 gui=NONE guifg=#000000 guibg=#fab955 | autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup=IncSearch, timeout=700}" \
  -c "autocmd TermEnter * stopinsert" \
  -c "autocmd TermClose * ${AUTOCMD_TERMCLOSE_CMD}" \
  -c "autocmd VimEnter * normal G" \
  -c "nmap p ? \\\|^\[.*\]<CR>" \
  -c "map <silent> q :<C-u>qa!<CR> | nmap <CR> :nohlsearch<CR> | nmap <ESC> :nohlsearch<CR> | nmap H zH | nmap L zL | nmap J <C-e> | nmap K <C-y> | nmap a <nop> | nmap i <nop>" \
  -c "silent write! /tmp/kitty_scrollback_buffer | terminal cat /tmp/kitty_scrollback_buffer -"
