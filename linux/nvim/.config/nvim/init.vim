scriptencoding utf-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vim-plug
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup end
endif

call plug#begin()

  " Defaults everyone can agree on
  Plug 'tpope/vim-sensible'

  " EditorConfig
  Plug 'editorconfig/editorconfig-vim'

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

  " Fancy UI stuff
  Plug 'anhpt379/fzf'
  Plug 'anhpt379/fzf.vim'
  Plug 'anhpt379/fzf-filemru'
  Plug 'chrisbra/Colorizer'
  Plug 'ryanoasis/vim-devicons'
  Plug 'breuckelen/vim-resize'
  Plug 'ptzz/lf.vim', {'tag': 'v1.2'} | Plug 'rbgrouleff/bclose.vim'
  Plug 'spektroskop/golden-ratio', {'branch': 'skip-popups'}
  Plug 'pechorin/any-jump.vim'
  Plug 'voldikss/vim-floaterm'

  " Improving editing experience
  Plug 'anhpt379/targets.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'tpope/vim-repeat'
  Plug 'inkarkat/vim-visualrepeat'
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-commentary'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'ethanholz/nvim-lastplace'
  Plug 'paretje/suda.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'anhpt379/vim-unimpaired'
  Plug 'rhysd/clever-f.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'cohama/lexima.vim'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-dispatch'
  Plug 'qxxxb/vim-searchhi'
  Plug 'inkarkat/vim-EnhancedJumps' | Plug 'inkarkat/vim-ingo-library'
  Plug 'sbdchd/neoformat'
  Plug 'tpope/vim-sleuth'
  Plug 'kana/vim-niceblock'
  Plug 'haya14busa/vim-asterisk'
  Plug 'google/vim-searchindex'
  Plug 'junegunn/vim-after-object'
  Plug 'jeetsukumaran/vim-indentwise'
  Plug 'anhpt379/ctrlsf.vim'
  Plug 'anhpt379/vim-move'
  Plug 'tyru/open-browser.vim'

  " Improve performance
  Plug 'antoinemadec/FixCursorHold.nvim'
  Plug 'lewis6991/impatient.nvim'

  " Heavily loaded plugins
  if $USER ==# 'vagrant'
    Plug 'dstein64/vim-startuptime'
    Plug 'mhinz/vim-startify'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'

    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'norcalli/nvim-colorizer.lua'

    Plug 'anhpt379/vim-fugitive'
    Plug 'anhpt379/vim-git-browse'

    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'lukas-reineke/cmp-rg'
    Plug 'anhpt379/cmp-mocword' | Plug 'anhpt379/plenary.nvim'
    Plug 'jose-elias-alvarez/null-ls.nvim' | Plug 'anhpt379/plenary.nvim'
    Plug 'ray-x/cmp-treesitter'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-lua/lsp-status.nvim'

    Plug 'lewis6991/gitsigns.nvim' | Plug 'anhpt379/plenary.nvim'

    Plug 'folke/trouble.nvim' | Plug 'kyazdani42/nvim-web-devicons'

    " For vsnip users.
    " Plug 'hrsh7th/cmp-vsnip'
    " Plug 'hrsh7th/vim-vsnip'

    " For luasnip users.
    " Plug 'L3MON4D3/LuaSnip'
    " Plug 'saadparwaiz1/cmp_luasnip'

    " For ultisnips users.
    " Plug 'SirVer/ultisnips'
    " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " For snippy users.
    " Plug 'dcampos/nvim-snippy'
    " Plug 'dcampos/cmp-snippy'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'SmiteshP/nvim-gps'
    Plug 'romgrk/nvim-treesitter-context'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'

    Plug 'rhysd/conflict-marker.vim'
    Plug 'andymass/vim-matchup'

    Plug 'wakatime/vim-wakatime'
  endif

call plug#end()

if $USER ==# 'vagrant'
  lua require('impatient')
endif

" Vim-startuptime
let g:startuptime_self = 1
let g:startuptime_more_info_key_seq = '<Space>'

" Open vim-plug in a new buffer
let g:plug_window = 'enew'

" ansible-vim
let g:ansible_attribute_highlight = 'ab'

" More natural split opening
set splitbelow
set splitright

" Enable mouse for all mode
set mouse=a

" Make mouse scrolling smoother, by scroll one line at a time
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

set pumblend=20
set cursorline

let g:is_posix = 1

set noswapfile
set nojoinspaces
set nowrap

set foldlevel=90
set nofoldenable

" Enable 24bit true color
set termguicolors

set noshowmode
set number

" Global replace by default
set gdefault

" Make it obvious where 80 characters is
set textwidth=79
set colorcolumn=+1

" Make the keyboard faaaaaaast
set ttimeoutlen=5

" Fix slow Gstatus
" https://github.com/tpope/vim-fugitive/issues/1176
" This also speeds up everything, vim becomes much faster after this change
set shell=/bin/bash
set shellcmdflag=-c

" Tweak for Markdown mode
augroup markdown
  autocmd FileType markdown call s:markdown_mode_setup()
augroup end

function! s:markdown_mode_setup()
  set wrap
  set textwidth=80
  set formatoptions+=t
endfunction

colorscheme aodark

set whichwrap+=<,>,h,l

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

" Insert spaces when Tab is pressed
set expandtab

" Automatically :write before running commands
set autowrite

" Persistent undo
set undofile
set undodir=~/.config/nvim/undo

" Searching and substitution {{{
set ignorecase
set smartcase

" Clear search/clever-f highlighting by pressing Enter/Esc
nnoremap <CR>  :nohlsearch<CR><Left><Right>
nnoremap <Esc> :nohlsearch<CR><Left><Right>

" Live substitution
set inccommand=split
" }}}

" Change the leader from \ to <Space>
let mapleader=' '
noremap <Space> <Nop>

" Quickly reload nvim config & update plugins by pressing `<Leader>u`
nnoremap <Leader>u :source ~/.config/nvim/init.vim<CR>
  \ :TSInstall all<CR>
  \ :PlugClean<CR>
  \ :silent !PlugInstall<CR>
  \ :PlugUpdate --sync<CR>
  \ :PlugUpgrade<CR>
  \ :PlugDiff<CR>

" Turn off whitespaces compare and folding in vimdiff
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical

" Use system clipboard
set clipboard=unnamedplus

" Disable auto wrap lines
set formatoptions-=t

" Lightline {{{
let g:lightline = {
  \ 'colorscheme': 'aodark',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['gitbranch', 'readonly', 'modified'],
  \     ['lsp_status', 'where_am_i']
  \   ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'DevIconsFugitiveHead',
  \   'filetype': 'DevIconsFileType',
  \   'fileformat': 'DevIconsFileFormat',
  \   'lsp_status': 'LspStatus',
  \   'where_am_i': 'Whereami',
  \ },
  \ }

function! LspStatus() abort
  if has_key(b:, 'lightline_lspstatus') &&
      \ reltimestr(reltime(b:lightline_lspstatus_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_lspstatus
  endif

  if luaeval('#vim.lsp.buf_get_clients() > 0')
    let lspstatus = luaeval("require('lsp-status').status()")

    let b:lightline_lspstatus = lspstatus
    let b:lightline_lspstatus_time = reltime()
    return b:lightline_lspstatus
  endif

  return ''
endfunction

function! Whereami() abort
  if has_key(b:, 'lightline_whereami') &&
      \ reltimestr(reltime(b:lightline_whereami_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_whereami
  endif

	let location = luaeval("require'nvim-gps'.is_available()") ?
    \ luaeval("require'nvim-gps'.get_location()") : ''

  let b:lightline_whereami = location
  let b:lightline_whereami_time = reltime()
  return b:lightline_whereami
endfunction

function! DevIconsFugitiveHead()
  if has_key(b:, 'lightline_fugitive') &&
      \ reltimestr(reltime(b:lightline_fugitive_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_fugitive
  endif

  let branch = FugitiveHead()
  if empty(branch)
    return ''
  endif
  let head = ' ' . branch

  let b:lightline_fugitive = head
  let b:lightline_fugitive_time = reltime()
  return b:lightline_fugitive
endfunction

function! DevIconsFileType()
  if has_key(b:, 'lightline_devicons_filetype') &&
      \ reltimestr(reltime(b:lightline_devicons_filetype_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_devicons_filetype
  endif

  let filetype = winwidth(0) > 70 ?
        \ (strlen(&filetype) ?
        \  WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''

  let b:lightline_devicons_filetype = filetype
  let b:lightline_devicons_filetype_time = reltime()
  return b:lightline_devicons_filetype
endfunction

function! DevIconsFileFormat()
  if has_key(b:, 'lightline_devicons_fileformat') &&
      \ reltimestr(reltime(b:lightline_devicons_fileformat_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_devicons_fileformat
  endif

  let fileformat = winwidth(0) > 70 ?
        \ (WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat) : ''

  let b:lightline_devicons_fileformat = fileformat
  let b:lightline_devicons_fileformat_time = reltime()
  return b:lightline_devicons_fileformat
endfunction

" Show vim tab line even if only one file is open
if $USER ==# 'vagrant'
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
  nmap <Leader>n :bnext<CR>
  nmap <Leader>p :bprevious<CR>
  nmap <Leader>w q
  nmap <Leader>q Q
  nmap <Leader>t :enew<CR>

  let g:lightline#bufferline#show_number     = 2
  let g:lightline#bufferline#shorten_path    = 1
  let g:lightline#bufferline#unnamed         = '[No Name]'
  let g:lightline#bufferline#enable_devicons = 1
  let g:lightline#bufferline#unicode_symbols = 1
  let g:lightline#bufferline#modified        = ' '
  let g:lightline#bufferline#read_only       = ' '
  let g:lightline#bufferline#clickable       = 1
  let g:lightline.separator                  = { 'left': '', 'right': '' }
  let g:lightline.subseparator               = { 'left': '', 'right': '' }

  let g:lightline#bufferline#number_map = {
    \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
    \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
    \ }

  let g:lightline.tabline          = {'left': [['buffers']], 'right': []}
  let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
  let g:lightline.component_type   = {'buffers': 'tabsel'}
  let g:lightline.component_raw    = {'buffers': 1}
endif

" }}}

" If hidden is not set, TextEdit might fail
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000
set updatetime=300

" Don't give |ins-completion-menu| messages
set shortmess+=c

" Always show signcolumns
set signcolumn=yes

" Accept completion with <CR> and <Tab>
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr> <Tab> pumvisible() ? '<C-y> ' : '<C-g>u<Tab>'

" " Navigate diagnostics
nmap <C-p> :lua vim.diagnostic.goto_prev()<CR>
nmap <C-n> :lua vim.diagnostic.goto_next()<CR>

" Jump to next/prev diagnostic from INSERT mode also
imap <silent> <C-n> <Esc><C-n>
imap <silent> <C-p> <Esc><C-p>

" No transparent auto-completion popup
set pumblend=0
set winblend=0

" FixCursorHold.nvim
let g:cursorhold_updatetime = 100

" Bclose
let g:bclose_no_plugin_maps = v:true

" Fzf {{{
let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1
let g:fzf_layout = {'window': 'enew'}
let g:fzf_preview_window = ['right:60%', 'ctrl-/']
let g:fzf_commits_log_options = '
  \ -5000 --color=always
  \ --format="%C(green)%h %C(reset)%s %C(#555555)%b(%aN - %cr)"
  \ '

command! -complete=dir -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always
  \       --smart-case --fixed-strings --hidden --glob "!.git" -- "'.escape(<q-args>, '$"').'" || true', 1,
  \   fzf#vim#with_preview({'options': ['--no-multi', '--layout=reverse', '--preview-window=right:60%', '--bind=ctrl-/:toggle-preview']}),
  \   <bang>0)

function! s:close_gstatus()
  for l:winnr in range(1, winnr('$'))
    if !empty(getwinvar(l:winnr, 'fugitive_status'))
      execute l:winnr.'close'
    endif
  endfor
endfunction
command! GstatusClose call s:close_gstatus()

noremap <Leader>g :GstatusClose<CR>:FzfRg<Space>
noremap <Leader>f :GstatusClose<CR>:silent FilesMru<CR>
noremap <Leader>b :FzfBLines<CR>
" }}}

" Git {{{
noremap gs :tab Git<CR>gg4j
noremap gl :FzfCommits<CR>
noremap gL :FzfBCommits<CR>
noremap <expr> gw &modified ? ':silent! Gwrite<CR>' : ''

command! Gundo               silent! G undo
command! Gstash              silent! G stash
command! Gstashpop           silent! G stash pop
command! Grebasecontinue     silent! G rebase --continue
command! Grebaseabort        silent! G rebase --abort
command! Gmergecontinue      silent! G merge --continue
command! Gmergeabort         silent! G merge --abort
command! Gcherrypickcontinue silent! G cherry-pick --continue
command! Gcherrypickabort    silent! G cherry-pick --abort

let g:dispatch_no_maps = 1
map m vgl

nmap g[ :Dispatch! noti 'git pull --rebase origin $(git branch \| grep -o -m1 "\b\(master\\|main\)\b")'<CR>
nmap g] :Dispatch! noti 'git push --force origin HEAD'<CR>:silent exec '!git rev-parse --short HEAD \| tr -d "\n" \| pbcopy'<CR>
nmap M  :Dispatch! noti 'git checkout $(git branch \| grep -o -m1 "\b\(master\\|main\)\b") && git pull --rebase origin $(git branch \| grep -o -m1 "\b\(master\\|main\)\b")'<CR>

augroup fugitive-personal-key-mappings
  autocmd FileType fugitive nmap <buffer> p :bd!<CR>
        \ :Dispatch! noti 'git push origin HEAD --force'<CR>
        \ :silent exec '!git rev-parse --short HEAD \| tr -d "\n" \| pbcopy'<CR>
  autocmd FileType fugitive nmap <buffer> P :Dispatch! noti 'git pull --rebase origin $(git branch \| grep -o -m1 "\b\(master\\|main\)\b")'<CR>
  autocmd FileType fugitive nmap <buffer> m
        \ :!if git branch -a \| grep remotes/ \| grep -q /$(git branch --show-current)$; test $? -eq 1; then
        \     git push --force origin HEAD;
        \   fi<CR>
        \ :<C-u>call vim_git_browse#GitOpenPullRequest()<CR>
        \ :silent exec '!git rev-parse --short HEAD \| tr -d "\n" \| pbcopy'<CR>

  " Verbose and quiet git commit by default
  autocmd FileType fugitive nmap <buffer> C  :vertical Git commit --quiet --no-status<CR>
  autocmd FileType fugitive nmap <buffer> cc :vertical Git commit --quiet --no-status<CR>
  autocmd FileType fugitive nmap <buffer> ca :vertical Git commit --quiet --no-status --amend<CR>
  autocmd FileType fugitive nmap <buffer> ce :Git commit --amend --quiet --no-status --no-edit<CR>

  " gw in gitcommit/gitrebase to save and close
  autocmd FileType gitcommit nmap <buffer> gw :x<CR>
  autocmd FileType gitrebase nmap <buffer> gw :x<CR>

  " gr to open repo in browser
  autocmd FileType fugitive nmap <buffer> gr :<C-u>call vim_git_browse#GitOpenRepo()<CR>

  " Open diff in a new buffer by default
  autocmd FileType fugitive map <buffer> <nowait> <CR> O

  " Easier to reach -= keys
  autocmd FileType fugitive map <buffer> <nowait> d =
  autocmd FileType fugitive map <buffer> <nowait> a -

  " x is easier to type than X
  autocmd FileType fugitive map <buffer> <nowait> x X

  " Left padding
  autocmd FileType fugitive set signcolumn=yes | set number
augroup end

augroup fugitive-auto-insert
  autocmd!
  autocmd BufEnter COMMIT_EDITMSG startinsert
augroup end
" }}}

" Use U as redo
nnoremap U <C-R>

" <C-c> (close) to save & close the current buffer
imap <C-c> <C-O>:x<CR>
nmap <C-c> :x<CR>

" Automatically jump to end of text you pasted
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Don't change the clipboard if paste over a visually selected text
xnoremap p "_dP`]

" Keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" Y yanks until EOL, more like D and C
" yy still yanks the whole line
nnoremap Y y$

" Improve scrolling performance
set lazyredraw
set regexpengine=1

" Navigate properly when lines are wrapped
noremap j gj
noremap k gk

" Start scrolling n lines before horizontal border of window
set scrolloff=5

" Start scrolling n chars before end of screen
set sidescrolloff=7

" Copy path to clipboard
command! CopyPath :call system('pbcopy', fnamemodify(expand("%"), ":~:."))

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing
nnoremap S i<CR><ESC>:StripWhitespace<CR>

" Use `==` for formatting the current line (or visual selection)
vnoremap == gw
nnoremap == Vgw

" These are to cancel the default behavior of d, D, c, C, s to put the text
" they delete in the default register.
" Note that this means e.g. "ad won't copy the text into register a anymore,
" you have to explicitly yank it.
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap s "_s
vnoremap s "_s

" Don't use clipboard when deleting chars using x/X in NORMAL mode
" (We still can cut in VISUAL mode with x/X)
nnoremap x "_x
nnoremap X "_X

" Disable <BS>/<Del> in NORMAL mode
nnoremap <BS>  <nop>
nnoremap <Del> <nop>

" Quick folding with `-`
nnoremap - za
vnoremap - za

" Comment stuff out
nmap <Leader>c gcc
vmap <Leader>c gc

" Join lines and restore cursor location (J)
nnoremap J mjJ`j

" Make it easier to increase/decrease values
map <Leader>= <C-a>
map <Leader>- <C-x>

" Faster search & replace with <C-r>
map <C-u> <Plug>(RepeatRedo)
nnoremap <C-r> :%s/<C-r><C-w>//<Left>
vnoremap <C-r> "hy:%s/<C-r>h//<Left>

" Select the last pasted text with vp (similar to the standard gv which you can
" type to select the last visually-selected text)
nnoremap <expr> vp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Disable continuation of comments to the next line in Vim
augroup format-options
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup end

" Lexima
let g:lexima_enable_basic_rules = 0
let g:lexima_map_escape = ''

" Sandwich
runtime macros/sandwich/keymap/surround.vim
xmap a <Plug>(operator-sandwich-add)
nmap yq ysiw'
nmap cq <Plug>(sandwich-replace-auto)
nmap dq <Plug>(sandwich-delete-auto)

" Close buffer with a single keypress
function! Goodbye()
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    q!
  else
    bd!
    blast
  endif
endfunction

map q :<C-u>silent! call Goodbye()<CR>

" Close all buffers without saving
nnoremap <silent> Q :q!<CR>

" Remap recording macro key to the delete key
" (I mapped the delete key to F20 in Karabiner)
nnoremap <F20> q

" Startify
let g:startify_disable_at_vimenter = 0
nmap <Leader>s :Startify<CR>

set shada=!,'5000,<2500,s500,h
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
let g:startify_enable_special = 0
let g:startify_update_oldfiles = 1

let g:startify_lists = [
  \ {'header': ['   MRU '. getcwd()], 'type': 'dir'},
  \ {'header': ['   Bookmarks'],      'type': 'bookmarks'},
  \ {'header': ['   Sessions'],       'type': 'sessions'},
  \ ]

let g:startify_bookmarks = [
  \ {'b': '~/dotfiles/macOS/Brewfile'},
  \ {'f': '~/dotfiles/linux/fish/.config/omf/init.fish'},
  \ {'v': '~/dotfiles/linux/nvim/.config/nvim/init.vim'},
  \ ]

augroup startified
  autocmd User Startified setlocal cursorline
  autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
augroup end

function! StartifyEntryFormat()
  return "WebDevIconsGetFileTypeSymbol(absolute_path) . ' ' . entry_path"
endfunction

" Custom file extensions / syntax highlighting
augroup custom-file-extensions
  autocmd BufReadPost *.rules set filetype=yaml
  autocmd BufReadPost *.eyaml set filetype=yaml
augroup end

" No magic search by default
map / /\V
map ? ?\V

" Highlight yanked text
autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=700}

" Automatically jump to end of text you pasted
vnoremap p :<C-u>set paste<CR>:let @a = system("pbpaste")<CR>"ap`]:set nopaste<CR>
nnoremap p :set paste<CR>:let @a = system("pbpaste")<CR>"ap`]:set nopaste<CR>
vnoremap P :<C-u>set paste<CR>:let @a = system("pbpaste")<CR>"aP`]:set nopaste<CR>
nnoremap P :set paste<CR>:let @a = system("pbpaste")<CR>"aP`]:set nopaste<CR>

" Don't change the clipboard if paste over a visually selected text
xnoremap p "_d:set paste<CR>:let @a = system("pbpaste")<CR>"aP`]:set nopaste<CR>

" Conflict-marker {{{
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

" }}}

" Vim-better-whitespace
let g:strip_whitespace_on_save = 0
let g:strip_whitelines_at_eof = 1
let g:better_whitespace_operator = ''

nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

function! DisableWhitespace()
  if &filetype =~# 'fugitive\|startify\|ctrlsf\|git\|man\|log'
    DisableWhitespace
  endif
endfunction

augroup disable-whitespace
  autocmd FileType * call DisableWhitespace()
augroup end

" Vim indentline {{{
set listchars=tab:→\ ,extends:»,precedes:«
set list

let g:indentLine_char = '┊'

" Make indentline and JSON quote concealing work well together
let g:indentLine_setConceal = 0
set conceallevel=1

" Hide fzf status line
augroup fzf
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler |
    \ autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup end

" }}}

" https://www.reddit.com/r/vim/comments/g1lx7e/i_made_a_command_to_autoformat_shell_commands/
command! -range FormatShellCmd <line1>!~/.config/nvim/bin/format_shell_cmd.py

" Easier split navigations
nnoremap <Down>  <C-W><C-J>
nnoremap <Up>    <C-W><C-K>
nnoremap <Right> <C-W><C-L>
nnoremap <Left>  <C-W><C-H>

" Resize split with Shift+Left/Right/Up/Down
nnoremap <silent> <S-Left>  :CmdResizeLeft<CR>
nnoremap <silent> <S-Down>  :CmdResizeDown<CR>
nnoremap <silent> <S-Up>    :CmdResizeUp<CR>
nnoremap <silent> <S-Right> :CmdResizeRight<CR>

" Don't create .netrwhist file
let g:netrw_dirhistmax = 0

" Disable :Gblame commit colors
" (it's really hard to see the commit hashes when this option is on)
let g:fugitive_dynamic_colors = 0

" Press `0` repeatedly to toggle between `^` and `0`
" (`0` is easier to reach than `^`)
function! ToggleHomeZero()
  let pos = getpos('.')
  execute 'normal! ^'
  if pos == getpos('.')
    execute 'normal! 0'
  endif
endfunction
nnoremap 0 :call ToggleHomeZero()<CR>

" Jump to left/right split using <C-h/l> (Home/End)
nnoremap <Home> <C-W><C-H>
nnoremap <End>  <C-W><C-L>

" Move the view a half screenwidth left/right with H/L
map H zH
map L zL

" Easier change list jumps
nnoremap <Leader>o g;
nnoremap <Leader>i g,

" Auto create dirs on save
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup auto-create-dir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup end

" Lf.vim
let g:lf_map_keys = 0
let g:lf_replace_netrw = 1
autocmd TermOpen  * if $USER ==# 'vagrant' | set showtabline=0 | endif | set nonumber | set signcolumn=no  | set mouse-=a
autocmd TermEnter * if $USER ==# 'vagrant' | set showtabline=0 | endif | set nonumber | set signcolumn=no  | set mouse-=a
autocmd TermLeave * if $USER ==# 'vagrant' | set showtabline=2 | endif | set number   | set signcolumn=yes | set mouse+=a
map <Leader>l :<C-u>Lf<CR>

" Clever-f
let g:clever_f_ignore_case = 0
let g:clever_f_smart_case = 0
let g:clever_f_fix_key_direction = 0
let g:clever_f_mark_direct = 1
let g:clever_f_across_no_line = 1

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
" set diffopt+=indent-heuristic

" A faster way to toggle line number
map [n :<C-u>set nonumber<CR>:set norelativenumber<CR>
map ]n :<C-u>set number<CR>:set relativenumber<CR>

" Vim searchhi
map n   <Plug>(searchhi-n)zz<Plug>SearchIndex
map N   <Plug>(searchhi-N)zz<Plug>SearchIndex
map *   <Plug>(asterisk-*)zz<Plug>(searchhi-update)
map #   <Plug>(asterisk-#)zz<Plug>(searchhi-update)
map g*  <Plug>(asterisk-g*)zz<Plug>(searchhi-update)
map g#  <Plug>(asterisk-g#)zz<Plug>(searchhi-update)

map z*  <Plug>(asterisk-z*)zz<Plug>(searchhi-update)
map z#  <Plug>(asterisk-z#)zz<Plug>(searchhi-update)
map gz* <Plug>(asterisk-gz*)zz<Plug>(searchhi-update)
map gz# <Plug>(asterisk-gz#)zz<Plug>(searchhi-update)

let g:searchhi_clear_all_asap = 1

nmap / <Plug>(searchhi-/)\V
nmap ? <Plug>(searchhi-?)\V

vmap / <Plug>(searchhi-v-/)\V
vmap ? <Plug>(searchhi-v-?)\V

" <C-o> <C-i> to jump within the same file only
let g:EnhancedJumps_CaptureJumpMessages = 0
let g:EnhancedJumps_no_mappings = 1
map <C-o> <Plug>EnhancedJumpsLocalOlder
map <C-i> <Plug>EnhancedJumpsLocalNewer

" Neoformat
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_basic_format_trim  = 1
let g:neoformat_enabled_yaml = ['prettierd']

" Vim parenmatch
let g:loaded_matchparen = 1

" Vim niceblock
silent! xmap <unique> I  <Plug>(niceblock-I)
silent! xmap <unique> gI <Plug>(niceblock-gI)
silent! xmap <unique> A  <Plug>(niceblock-A)

" Vim puppet
augroup puppet
  " Disable auto wrap long lines
  autocmd FileType puppet set formatexpr=
augroup end

" Use Option+H/L to move around in vim command line
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Fix Option/Ctrl+Backspace/Delete didn't work in vim command line
cnoremap <M-BS> <C-w>
cnoremap <expr> <M-Del> &cedit. 'dw' .'<C-c><Space><BS>'
cnoremap <expr> <C-Del> &cedit. 'dW' .'<C-c><Space><BS>'

" Map Ctrl-Backspace to delete the previous word in insert mode
set backspace=indent,eol,start
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

" Fzf-mru
augroup update-mru-on-file-open
  autocmd!
  autocmd BufWinEnter * UpdateMru
augroup end

" Vim-git-browse
let g:vim_git_browse_use_default_keymap = 0
nnoremap <silent> go :<C-u>call vim_git_browse#GitBrowse(v:false, 'master')<CR>
xnoremap <silent> go :<C-u>call vim_git_browse#GitBrowse(v:true, 'master')<CR>
nnoremap <silent> gO :<C-u>call vim_git_browse#GitBrowse(v:false)<CR>
xnoremap <silent> gO :<C-u>call vim_git_browse#GitBrowse(v:true)<CR>
nnoremap <silent> gp :<C-u>call vim_git_browse#GitOpenPipelines()<CR>
nnoremap <silent> gr :<C-u>call vim_git_browse#GitOpenRepo()<CR>
nnoremap <silent> gm :!if git branch -a \| grep remotes/ \| grep -q /$(git branch --show-current)$; test $? -eq 1; then
                   \     git push --force origin HEAD;
                   \   fi<CR>
                   \ :<C-u>call vim_git_browse#GitOpenPullRequest()<CR>
                   \ :silent exec '!git rev-parse --short HEAD \| tr -d "\n" \| pbcopy'<CR>

" Suda & vim-eunuch
let g:suda_smart_edit = 1
let g:suda#try_without_password = !has('nvim')
command! SudoWrite w suda://%

" Floaterm
let g:floaterm_wintype = 'split'
let g:floaterm_autoclose = 1
let g:floaterm_open_in_root = v:true
let g:floaterm_shell = '/usr/bin/fish'

augroup floaterm
  autocmd User Startified setlocal buflisted
augroup end

nnoremap gb :FloatermNew! gb<CR>

" Vim-after-object: change/delete/select text *after* a character
augroup vim-after-object
  autocmd VimEnter * silent! call after_object#enable([']', '['], '=', ':', '#', ' ', '|', '*')
augroup end

" ]i and [i to go to next/previous indentation level
nmap <silent> ]i <Plug>(IndentWiseNextGreaterIndent)
nmap <silent> [i <Plug>(IndentWisePreviousLesserIndent)

" `gx` in VISUAL mode to perform google I'm feeling lucky search on
" the selected text
function! GoogleSearchImFeelingLucky()
  let searchterm = getreg('g')
  silent! exec 'silent! !open "http://www.google.com/search?sourceid=navclient&gfns=1&q=' . searchterm . '" &'
endfunction
vnoremap gx "gy<Esc>:call GoogleSearchImFeelingLucky()<CR>

" ENTER in VISUAL mode to start EasyAlign
vmap <Enter> <Plug>(EasyAlign)

" CtrlSF
nmap <C-s><C-f> :CtrlSF -- ""<Left>
vmap <C-s><C-f> <Plug>CtrlSFVwordExec
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_ignore_dir = ['.git']
let g:ctrlsf_case_sensitive = 'yes'
let g:ctrlsf_confirm_unsaving_quit = 0
let g:ctrlsf_position = 'left'
let g:ctrlsf_indent = 2
let g:ctrlsf_auto_close = 0
let g:ctrlsf_auto_focus = { 'at' : 'start' }
let g:ctrlsf_auto_preview = 0
let g:ctrlsf_winsize = '100%'
let g:ctrlsf_backend = 'rg'
let g:ctrlsf_extra_backend_args = {
  \ 'rg': '--fixed-strings --hidden --glob "!.git"'
  \ }
let g:ctrlsf_mapping = {
  \   'open'    : '',
  \   'openb'   : '',
  \   'split'   : '',
  \   'vsplit'  : '',
  \   'tab'     : '',
  \   'tabb'    : '',
  \   'popen'   : '',
  \   'popenf'  : '',
  \   'quit'    : 'q',
  \   'next'    : 'n',
  \   'prev'    : 'N',
  \   'pquit'   : 'q',
  \   'loclist' : '',
  \   'chgmode' : '',
  \   'stop'    : '<C-C>',
  \ }
func! CtrlSFAfterMainWindowInit()
    silent! nnoremap <silent><buffer> <Enter> :call ctrlsf#JumpTo('open') \| call ctrlsf#win#FocusMainWindow()<CR>
endf

augroup ctrlsf-key-mappings
  autocmd FileType ctrlsf nmap <buffer> gw :w<CR>
augroup end

" open-browser.vim
" Use gx to open URL under the cursor.
" This uses open-browser.vim instead of netrw_gx, since it detects URL better
" in some cases, like this one:
"
"   ['https://github.com/']
"
let g:netrw_nogx = 1
let g:openbrowser_browser_commands = [{'name': 'open', 'args': ['{browser}', '{uri}']}]
nmap gx <Plug>(openbrowser-smart-search)

" Indent Blankline
let g:indent_blankline_use_treesitter = v:true
let g:indent_blankline_show_first_indent_level = v:true
let g:indent_blankline_buftype_exclude = ['terminal']
let g:indent_blankline_filetype_exclude = ['fzf', 'startify', 'man', 'log']

" Persist and provide a clearer message to explain what has happened when Vim
" notices that the file you are editing was changed by another program (like
" git, or another editor).
augroup FCSHandler
  autocmd FileChangedShell * call FCSHandler(expand('<afile>:p'))
augroup END

function! FCSHandler(name)
  let msg = 'File "'.a:name.'"'
  let v:fcs_choice = ''
  if v:fcs_reason ==# 'deleted'
    let msg .= ' no longer available'
  elseif v:fcs_reason ==# 'time'
    let msg .= ' timestamp changed'
  elseif v:fcs_reason ==# 'mode'
    let msg .= ' permissions changed'
  elseif v:fcs_reason ==# 'changed'
    let msg .= ' contents changed'
    let v:fcs_choice = 'ask'
  elseif v:fcs_reason ==# 'conflict'
    let msg .= ' CONFLICT --'
    let msg .= ' is modified, but'
    let msg .= ' was changed outside Vim'
    let v:fcs_choice = 'ask'
    echohl Error
  else  " unknown values (future Vim versions?)
    let msg .= ' FileChangedShell reason='
    let msg .= v:fcs_reason
    let v:fcs_choice = 'ask'
  endif
  redraw!
  echohl Error
  echon msg
  echohl None
endfunction

" Vim-move
let g:move_map_keys = 0
let g:move_auto_indent = 0
let g:move_past_end_of_line = 0
vmap [e <Plug>MoveBlockUp
vmap ]e <Plug>MoveBlockDown
vmap [c <Plug>MoveBlockLeft
vmap ]c <Plug>MoveBlockRight
nmap [e <Plug>MoveLineUp
nmap ]e <Plug>MoveLineDown
nmap [c <Plug>MoveCharLeft
nmap ]c <Plug>MoveCharRight

" Tree-sitter based folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" <C-hjkl> to jump 2 lines/chars at a time
" Below we're using <PageUp/Down> <Home/End> due to the maps in Karabiner
map <PageDown> 2j
map <PageUp> 2k
map <Home> 2h
map <End> 2l

" Disable TreeSitterContext in Dockerfile (it's incompatible at the moment -
" nvim shows treesitter context errors every time we move the cursor)
augroup dockerfile
  autocmd FileType Dockerfile :TSContextDisable
augroup end

" Lua config
if $USER ==# 'vagrant'
  luafile <sfile>:h/config.lua
endif

" Format code on file save
function! FormatCode()
  let script_file =
        \ trim(system(['git', 'rev-parse', '--show-toplevel'])) .
        \ '/scripts/format-' . &filetype . '.sh'
  if v:shell_error != 0 || !filereadable(script_file)
    return
  endif

  let cursor = getpos('.')

  let temp_file = tempname()
  execute 'silent noautocmd w ' . temp_file
  let output = system([script_file, temp_file])
  if v:shell_error == 0
    execute 'silent %!cat ' . temp_file
  else
    echo output
  endif
  call delete(temp_file)

  call setpos('.', cursor)
endfunction

augroup format_code_on_save
  autocmd FileType puppet autocmd BufWritePre <buffer> call FormatCode()
  autocmd FileType yaml autocmd BufWritePre <buffer> call FormatCode()
augroup end
