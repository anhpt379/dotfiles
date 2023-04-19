call plug#begin()
  Plug 'ojroques/vim-oscyank'

  " Syntax highlighting
  Plug 'gisphm/vim-gitignore'
  Plug 'chr4/nginx.vim'
  Plug 'glench/vim-jinja2-syntax'
  Plug 'rodjek/vim-puppet'
  Plug 'pearofducks/ansible-vim'
  Plug 'mechatroner/rainbow_csv'
  Plug 'ericpruitt/tmux.vim'
  Plug 'khaveesh/vim-fish-syntax'
  Plug 'CH-DanReif/haproxy.vim'
  Plug 'towolf/vim-helm'
  Plug 'MTDL9/vim-log-highlighting'
  Plug 'wgwoods/vim-systemd-syntax'
  Plug 'raimon49/requirements.txt.vim'
  Plug 'hashivim/vim-terraform'
  Plug 'VebbNix/lf-vim'
  Plug 'rhysd/vim-syntax-codeowners'
call plug#end()

colorscheme aodark

set clipboard+=unnamedplus

set incsearch
set ignorecase
set smartcase

set nomodeline
set noswapfile

set wrap
noremap j gj
noremap k gk

let g:loaded_matchparen = 1

lua nvimpager.maps = false

nmap c /commit [a-z0-9]\{40}\\|added: .\+$\\|deleted: .\+$\\|modified: .\+$<CR>
nmap a ?Applied catalog in .* seconds<CR>

nmap <CR>  :nohlsearch<CR>
nmap <ESC> :nohlsearch<CR>

nmap H zh
nmap L zl
nmap J <C-e>
nmap K <C-y>

nmap i <nop>
nmap I <nop>
nmap s <nop>

map  q :<C-u>qa!<CR>

" Use Option+H/L to jump word by word in vim command line
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Fix Option/Ctrl+Backspace/Delete didn't work in vim command line
cnoremap <M-BS> <C-w>
cnoremap <expr> <C-BS>  &cedit. 'dB' .'<C-c><Space><BS>'
cnoremap <expr> <M-Del> &cedit. 'dw' .'<C-c><Space><BS>'
cnoremap <expr> <C-Del> &cedit. 'dW' .'<C-c><Space><BS>'

" Make mouse scrolling smoother, by scroll one line at a time
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" F to toggle "follow mode"
map F :lua nvimpager.toggle_follow()<CR>

" Hide `E211: file no longer available` on `cat <file> | nvimpager -p`
augroup suppress-file-no-longer-available-warning
  autocmd FileChangedShell * :
augroup end

augroup strip-ansi-color-codes
  autocmd TextYankPost * call system("sed -e 's/\x1B\[[0-9;]*[JKmsu]//g' \| pbcopy", @0)
augroup end

" vim-oscyank
augroup oscyank
  autocmd TextYankPost *
      \ if v:event.operator is 'y' |
      \ execute 'OSCYankRegister "' |
      \ endif
augroup end
