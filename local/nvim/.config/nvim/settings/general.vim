" Set leader key (must be set before any <Leader> mappings)
let mapleader=' '
noremap <Space> <Nop>

" Basic settings
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Indentation
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Scrolling
set scrolloff=5
set sidescrolloff=7
set lazyredraw

" Clipboard
set clipboard=unnamedplus

" Wrapping
set whichwrap+=<,>,h,l
set formatoptions-=tc

" Undo & history
set undofile
set undodir=~/.local/state/nvim/undo
set shada=!,'5000,<2500,s500,h
set shadafile=~/.local/state/nvim/shada/main.shada

" Automatically :write before running commands
set autowrite

" Backspace behavior
set backspace=indent,eol,start

" Diff settings
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical
set diffopt+=algorithm:patience

" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Performance
set regexpengine=1

" Completion menu
set pumblend=0
set winblend=0

" List chars
set listchars=tab:→\ ,extends:»,precedes:«
set list

" Conceal
set conceallevel=0

" Disable netrw history
let g:netrw_dirhistmax = 0

