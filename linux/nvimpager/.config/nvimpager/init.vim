call plug#begin()
  " Syntax highlighting
  Plug 'gisphm/vim-gitignore'
  Plug 'chr4/nginx.vim'
  Plug 'glench/vim-jinja2-syntax'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'rodjek/vim-puppet'
  Plug 'pearofducks/ansible-vim'
  Plug 'mechatroner/rainbow_csv'
  Plug 'ericpruitt/tmux.vim'
  Plug 'georgewitteman/vim-fish'
  Plug 'CH-DanReif/haproxy.vim'
  Plug 'towolf/vim-helm'
  Plug 'MTDL9/vim-log-highlighting'
  Plug 'wgwoods/vim-systemd-syntax'
  Plug 'raimon49/requirements.txt.vim'
  Plug 'hashivim/vim-terraform'
  Plug 'VebbNix/lf-vim'
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

nmap C /commit [a-z0-9]\{40}\\|added: .\+$\\|deleted: .\+$\\|modified: .\+$<CR>
nmap A ?Applied catalog in .* seconds<CR>

nmap <CR>  :nohlsearch<CR>
nmap <ESC> :nohlsearch<CR>

nmap H zh
nmap L zl
nmap J <C-e>
nmap K <C-y>

nmap a <nop>
nmap i <nop>
nmap c <nop>
nmap s <nop>
nmap I <nop>

map  q :<C-u>qa!<CR>

" Make mouse scrolling smoother, by scroll one line at a time
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" F to reread the file, partially similar to less +F
nmap F :e<CR>

" Hide `E211: file no longer available` on `cat <file> | nvimpager -p`
augroup suppress-file-no-longer-available-warning
  autocmd FileChangedShell * :
augroup end

augroup strip-ansi-color-codes
  autocmd TextYankPost * call system("sed -e 's/\x1B\[[0-9;]*[JKmsu]//g' \| pbcopy", @0)
augroup end
