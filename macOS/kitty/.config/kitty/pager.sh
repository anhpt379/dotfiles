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

exec /usr/local/bin/nvim \
  -u NONE \
  -c "map <silent> q :<C-u>qa!<CR>" \
  -c "set shell=bash scrollback=100000 laststatus=0 clipboard+=unnamedplus nowrap incsearch ignorecase smartcase" \
  -c "autocmd TermEnter * stopinsert" \
  -c "autocmd TermClose * ${AUTOCMD_TERMCLOSE_CMD}" \
  -c "nmap P ?^ \\\|^\[.*\]<CR>" \
  -c "nmap <CR>  :nohlsearch<CR>" \
  -c "nmap <ESC> :nohlsearch<CR>" \
  -c "nmap H zH | nmap L zL | nmap h zh | nmap l zl" \
  -c "nmap a <nop> | nmap i <nop>" \
  -c 'terminal sed </dev/fd/63 -e "s/'$'\x1b'']8;;file:[^\]*[\]//g" && sleep 0.01 && printf "'$'\x1b'']2;"' 63<&0 0</dev/null