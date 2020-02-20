call plug#begin()

"Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Changes Vim working directory to project root
Plug 'airblade/vim-rooter'

" Some Git stuff
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

" EditorConfig
Plug 'editorconfig/editorconfig-vim'

" LSP support
Plug 'anhpt379/coc.nvim', { 'do': 'yarn install --frozen-lockfile' }

" Fancy UI stuff
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'liuchengxu/vista.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-startify'
Plug 'rhysd/git-messenger.vim'
Plug 'lifepillar/vim-cheat40'

" Improving editing experience
Plug 'machakann/vim-sandwich'
Plug 'haya14busa/incsearch.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'pbrisbin/vim-mkdir'
Plug 'brooth/far.vim'
Plug 'farmergreg/vim-lastplace'
Plug 'lambdalisue/suda.vim'
Plug 'rhysd/clever-f.vim'
Plug 'taku-o/vim-toggle'
Plug 'tpope/vim-unimpaired'
Plug 'sjl/gundo.vim'

" Time tracking
Plug 'wakatime/vim-wakatime'

" Smart selection of the closest text object
Plug 'terryma/vim-expand-region'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-indent'

call plug#end()

let g:coc_global_extensions = [
      \  'coc-pairs',
      \  'coc-highlight',
      \  'coc-prettier',
      \  'coc-git',
      \  'coc-python',
      \  'coc-json',
      \  'coc-html',
      \  'coc-css',
      \  'coc-fish',
      \  'coc-markdownlint',
      \  'coc-yaml',
      \  'coc-docker',
      \  'coc-sh',
      \  'coc-dictionary',
      \  'coc-emoji',
      \  'coc-snippets',
      \  'coc-yank'
      \ ]

" coc-dictionary
set dictionary+=~/.config/nvim/dictionaries/hacker_news.txt

" More natural split opening
set splitbelow
set splitright

" vim-expand-region
let g:expand_region_text_objects = {
      \ 'iw' : 0,
      \ 'iW' : 0,
      \ 'i"' : 0,
      \ 'i''': 0,
      \ 'i)' : 1,
      \ 'i]' : 1,
      \ 'ib' : 1,
      \ 'iB' : 1,
      \ 'il' : 0,
      \ 'ip' : 0,
      \ 'ie' : 0,
      \ 'a]' : 1,
      \ 'ab' : 1,
      \ 'aB' : 1,
      \ 'ii' : 0,
      \ 'ai' : 0
      \ }

noremap ) <Plug>(expand_region_expand)
noremap ( <Plug>(expand_region_shrink)

" git-messenger
let g:git_messenger_always_into_popup = v:true

" load filetype-specific indent files
filetype plugin indent on

set guifont=Meslo_Nerd_Font:14

set encoding=UTF-8
set mouse=a   " enable mouse for all mode
set wildoptions=pum
set pumblend=20
set cursorline

set foldmethod=indent
set foldlevel=99

let g:is_posix = 1

set noswapfile
set nojoinspaces
set nowrap
set laststatus=2
set termguicolors    " enable 24bit true color
set colorcolumn=80
set noshowmode
set number

" Make the keyboard faaaaaaast
set ttyfast
set timeout timeoutlen=1000 ttimeoutlen=10

" Tweak for Markdown mode
autocmd FileType markdown call s:markdown_mode_setup()
function! s:markdown_mode_setup()
  set wrap
  set nonumber
  set textwidth=80
  set formatoptions+=t
endfunction

" vnoremap <M-/> <Esc>/\%V
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

set background=dark
let g:quantum_italics=1
colorscheme quantum

if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
	syntax on
endif

set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set list

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab     " Insert spaces when TAB is pressed

set autoindent
set smartindent

set autoread
set autowrite     " Automatically :write before running commands

" Persistent undo
if has('persistent_undo') && isdirectory(expand('~').'/.config/nvim/undo')
  silent !mkdir ~/.config/nvim/undo > /dev/null 2>&1

  set undofile
  set undodir=~/.config/nvim/undo
  set undolevels=1000
  set undoreload=10000
endif

" No transparent floating windows
set pumblend=0
set winblend=0

" === NerdTree === "

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=['\.DS_Store', '\~$', '\.swp', '\.git', '__pycache__', '\.pyc$']
let NERDTreeAutoDeleteBuffer = 1
let g:NERDSpaceDelims = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)


" Floating Term
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let top = "╭" . repeat("─", width + 2) . "╮"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "╰" . repeat("─", width + 2) . "╯"
  let lines = [top] + repeat([mid], height) + [bot]
  let bbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(bbuf, 0, -1, v:true, lines)
  let s:float_term_border_win = nvim_open_win(bbuf, v:true, border_opts)
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:Normal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)
endfunction

" Key binding
let mapleader=' '

nnoremap <Leader>cr :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>pi :PlugInstall<CR>
nnoremap <Leader>pu :PlugUpdate<CR>
nnoremap <Leader>pc :PlugClean<CR>

" Open terminal
nnoremap <Leader>at :call FloatTerm()<CR>

" Open tig, yes TIG, A FLOATING TIGGGG!!!!!!
nnoremap <Leader>ag :call FloatTerm('"tig"')<CR>

" Turn off whitespaces compare and folding in vimdiff
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical

set clipboard=unnamed

let g:lightline = {
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'cocstatus', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name',
  \   'cocstatus': 'coc#status'
  \ },
  \ }

" === lightline-bufferline === "
set showtabline=2

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#filename_modifer = ':t'

let g:lightline#bufferline#number_map = {
\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}

let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" === coc.vim === "
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Navigate diagnostics
nmap <silent> <Leader>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <Leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <Leader>f  <Plug>(coc-format-selected)
" nmap <Leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<Leader>aap` for current paragraph
xmap <Leader>a  <Plug>(coc-codeaction-selected)
nmap <Leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <Leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <Leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}


set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Some custom style
highlight Normal guibg=NONE
highlight NonText guifg=#354751
highlight VertSplit guifg=#212C32
highlight WildMenu guibg=NONE guifg=#87bb7c
highlight CursorLineNr guibg=NONE

" LeaderF
highlight def Lf_hl_popup_prompt guifg=#ffcd4a guibg=NONE
highlight def Lf_hl_popup_spin guifg=#e6e666 guibg=NONE
highlight def Lf_hl_popup_inputMode guifg=#005f60 guibg=#FFFFFF
highlight def Lf_hl_popup_normalMode guifg=#085b0b guibg=#b0dd2c
highlight def Lf_hl_popup_category guifg=#FFFFFF guibg=#1488ad
highlight def Lf_hl_popup_fullPathMode guifg=#7c0308 guibg=#fd8724
highlight def Lf_hl_popup_regexMode guifg=#FFFFFF guibg=#FF2929
highlight def Lf_hl_popup_fuzzyMode guifg=#004747 guibg=#FFFFFF
highlight def Lf_hl_popup_nameOnlyMode guifg=#000000 guibg=#7FECAD
highlight def Lf_hl_popup_cwd guifg=#FFFFFF guibg=#585858
highlight def Lf_hl_popup_lineInfo guifg=#C9C9C9 guibg=#585858
highlight def Lf_hl_popup_total guifg=#545454 guibg=#D0D0D0

let g:Lf_HideHelp = 1
let g:Lf_IgnoreCurrentBufferName = 0

let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_RecurseSubmodules = 1

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 0
let g:Lf_StlSeparator = { 'left': "", 'right': "" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<Leader>f"

noremap <Leader>b :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <Leader>r :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <Leader>t :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <Leader>l :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <Leader>s :<C-U><C-R>=printf("Leaderf! rg -e ")<CR>


" vista

" How each level is indented and what to prepend.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ 'py': 'vim_lsp'
  \ }

" Hybrid line numbers
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" KEY MAPPINGS

" Use U as redo
nnoremap U <C-R>

" New file
noremap <Leader>e :enew<CR>

" Git
noremap <Leader>gs :vertical Gstatus<CR>
noremap <Leader>gl :GV<CR>

" Remap recording macro key to `2` (`q` will be using as 'quit' to close the
" current buffer)
nnoremap 2 q

" Allow close a buffer and quit vim with a single keypress
nnoremap q :bd<CR>
nnoremap Q :qa!<CR>

" Saving quicker
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>i

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Automatically jump to end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Tab to switch between open buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" far.vim
let g:far#source = 'rgnvim'

" Improve scrolling performance
set lazyredraw
set regexpengine=1

" Make double-<Esc> clear search highlights
nnoremap <ESC><ESC> :nohlsearch<CR>

" Navigate properly when lines are wrapped
noremap j gj
noremap k gk

" Start scrolling n lines before horizontal border of window.
set scrolloff=5

" Start scrolling n chars before end of screen.
set sidescrolloff=7
set sidescroll=1

" Allow saving of files as sudo when I forgot to start vim using sudo.
" `:w !sudo tee % > /dev/null` trick does not work on neovim
command W w suda://%

" Insert mode navigational keys
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" Open/close NERDTree
nmap <Leader>n :NERDTreeToggle<CR>

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing
nnoremap S i<CR><ESC>

" gundo
let g:gundo_prefer_python3 = 1
let g:gundo_width = 80
let g:gundo_preview_height = 30
let g:gundo_right = 1
nnoremap <Leader>gu :GundoToggle<CR>

" coc-yank
nnoremap <silent> <Space>y  :<C-u>CocList --normal yank<CR>
