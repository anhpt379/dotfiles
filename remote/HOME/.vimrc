" A minimal .vimrc file

map q :q!<CR>
map Q :q!<CR>
map gw :update<CR>

set nowrap
set number

" Insert spaces when Tab is pressed
set expandtab

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

" Persistent undo
set undofile

" Searching and substitution
set incsearch
set ignorecase
set smartcase

" Change cursor shape to block when in NORMAL mode, and vertical line when in
" INSERT mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Fix slow vim escape from INSERT mode
set ttimeoutlen=5

" Move the view a half screenwidth left/right with H/L
map H zH
map L zL

" Start scrolling n lines before horizontal border of window
set scrolloff=5

" Start scrolling n chars before end of screen
set sidescrolloff=7

" No magic search by default
map / /\V
map ? ?\V

" Use U as redo
nnoremap U <C-R>

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing
nnoremap S i<CR><ESC>
nnoremap J mjJ`j

" Clear search/clever-f highlighting by pressing Enter
nnoremap <CR>       :nohlsearch<CR><Left><Right>
nnoremap <Esc><Esc> :nohlsearch<CR><Left><Right>

" Clipboard
if filereadable(expand('~/.local/bin/termux-clipboard-set'))
  nnoremap y0  y0:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap y$  y$:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap ye  ye:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap yE  yE:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap yw  yw:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap yW  yW:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap yy  yy:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap yiw yiw:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap yib yib:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap yiq yiq:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  nnoremap Y   Y:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
  vnoremap y   y:call system("~/.local/bin/termux-clipboard-set", @0)<CR>
endif

if filereadable(expand('~/.local/bin/termux-clipboard-get'))
  " Automatically jump to end of text you pasted
  vnoremap p :<C-u>set paste<CR>:let @a = system("~/.local/bin/termux-clipboard-get")<CR>"ap`]:set nopaste<CR>
  nnoremap p :set paste<CR>:let @a = system("~/.local/bin/termux-clipboard-get")<CR>"ap`]:set nopaste<CR>
  vnoremap P :<C-u>set paste<CR>:let @a = system("~/.local/bin/termux-clipboard-get")<CR>"aP`]:set nopaste<CR>
  nnoremap P :set paste<CR>:let @a = system("~/.local/bin/termux-clipboard-get")<CR>"aP`]:set nopaste<CR>

  " Don't change the clipboard if paste over a visually selected text
  xnoremap p "_d:set paste<CR>:let @a = system("~/.local/bin/termux-clipboard-get")<CR>"aP`]:set nopaste<CR>
endif

" Fix vim x/X in VISUAL mode doesn't copy text to macOS' clipboard
vnoremap x ygvx
vnoremap X ygvX

" Use a less distracting color for line number column
highlight LineNr ctermfg=green
highlight Visual ctermfg=0 ctermbg=15
