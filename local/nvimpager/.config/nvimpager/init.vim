set runtimepath+=~/.config/nvim

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'mireq/large_file'

  " Syntax highlighting
  Plug 'gisphm/vim-gitignore'
  Plug 'chr4/nginx.vim'
  Plug 'glench/vim-jinja2-syntax'
  Plug 'rodjek/vim-puppet'
  Plug 'pearofducks/ansible-vim'
  Plug 'ericpruitt/tmux.vim'
  Plug 'khaveesh/vim-fish-syntax'
  Plug 'CH-DanReif/haproxy.vim'
  Plug 'towolf/vim-helm'
  Plug 'anhpt379/vim-log-highlighting'
  Plug 'wgwoods/vim-systemd-syntax'
  Plug 'raimon49/requirements.txt.vim'
  Plug 'hashivim/vim-terraform'
  Plug 'VebbNix/lf-vim'
  Plug 'rhysd/vim-syntax-codeowners'
call plug#end()

colorscheme aodark

set termguicolors

set clipboard+=unnamedplus

set incsearch
set ignorecase
set smartcase

set nomodeline
set noswapfile

set mousescroll=ver:1,hor:0
set smoothscroll

set undofile
set undodir=~/.local/state/nvim/undo
set shada=!,'5000,<2500,s500,h
set shadafile=~/.local/state/nvim/shada/main.shada

noremap j gj
noremap k gk

set scrolloff=5
set sidescrolloff=7

lua nvimpager.maps = false

lua require("large_file").setup()

nmap C /commit [a-z0-9]\{40}\\|added: .\+$\\|deleted: .\+$\\|modified: .\+$<CR>
nmap A ?Applied catalog in .* seconds<CR>

nmap <CR>  :nohlsearch<CR>
nmap <ESC> :nohlsearch<CR>

nmap <PageUp>   20<C-y>
nmap <PageDown> 20<C-e>
nmap <Home>     20zh
nmap <End>      20zl
nmap <Up>       <C-y>
nmap <Down>     <C-e>
nmap <Left>     zh
nmap <Right>    zl

nmap i <nop>
nmap I <nop>
nmap s <nop>

map  q :<C-u>qa!<CR>

" A faster way to toggle wrap
map [w :<C-u>set wrap!<CR>
map ]w :<C-u>set wrap!<CR>

" Use Option+H/L to jump word by word in vim command line
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Fix Option/Ctrl+Backspace/Delete didn't work in vim command line
cnoremap <M-BS> <C-w>
cnoremap <expr> <C-BS>  &cedit. 'dB' .'<C-c><Space><BS>'
cnoremap <expr> <M-Del> &cedit. 'dw' .'<C-c><Space><BS>'
cnoremap <expr> <C-Del> &cedit. 'dW' .'<C-c><Space><BS>'

" F to toggle "follow mode"
map F :lua nvimpager.toggle_follow()<CR>

" Hide `E211: file no longer available` on `cat <file> | nvimpager -p`
augroup suppress-file-no-longer-available-warning
  autocmd FileChangedShell * :
augroup end

augroup strip-ansi-color-codes
  autocmd TextYankPost * call system("sed -e 's/\x1B\[[0-9;]*[JKmsu]//g' \| pbcopy", @0)
augroup end

augroup copy_text_to_clipboard_on_focus_lost
  autocmd FocusLost * silent! normal! "*ygv
augroup end

" Highlight yanked text
autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="TextYankPost", timeout=700}
