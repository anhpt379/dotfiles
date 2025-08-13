scriptencoding utf-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vim-plug
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup end
endif

let g:hostname = hostname()

call plug#begin()

  " Defaults everyone can agree on
  Plug 'tpope/vim-sensible'

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

  " Fancy UI stuff
  Plug 'chrisbra/Colorizer'
  Plug 'ryanoasis/vim-devicons'
  Plug 'breuckelen/vim-resize'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'roman/golden-ratio'

  " Improving editing experience
  Plug 'anhpt379/targets.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'tpope/vim-repeat'
  Plug 'inkarkat/vim-visualrepeat'
  Plug 'kylechui/nvim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'farmergreg/vim-lastplace'
  Plug 'paretje/suda.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-unimpaired'
  Plug 'folke/flash.nvim', {'tag': 'stable'}
  Plug 'junegunn/vim-easy-align'
  Plug 'cohama/lexima.vim'
  Plug 'tpope/vim-speeddating'
  Plug 'anhpt379/vim-dispatch'
  Plug 'qxxxb/vim-searchhi'
  Plug 'NMAC427/guess-indent.nvim'
  Plug 'kana/vim-niceblock'
  Plug 'haya14busa/vim-asterisk'
  Plug 'google/vim-searchindex'
  Plug 'junegunn/vim-after-object'
  Plug 'jeetsukumaran/vim-indentwise'
  Plug 'anhpt379/ctrlsf.vim'
  Plug 'anhpt379/vim-move'
  Plug 'tyru/open-browser.vim'
  Plug 'svban/YankAssassin.vim'
  Plug 'mireq/large_file'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'shumphrey/fugitive-gitlab.vim'

  " Heavily loaded plugins
  if g:hostname =~# 'fedora'
    Plug 'dstein64/vim-startuptime'
    Plug 'mhinz/vim-startify'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'

    Plug 'mechatroner/rainbow_csv'
    Plug 'fladson/vim-kitty'

    Plug 'echasnovski/mini.indentscope', { 'branch': 'stable' } | Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
    Plug 'norcalli/nvim-colorizer.lua'

    " Plug 'Saghen/blink.cmp', {'tag': 'v0.6.2', 'do': 'cargo +nightly build --release'}
    " Plug 'Saghen/blink.compat' | Plug 'anhpt379/cmp-mocword' | Plug 'anhpt379/plenary.nvim'
    " Plug 'mikavilpas/blink-ripgrep.nvim'

    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim' | Plug 'williamboman/mason-lspconfig.nvim', {'tag': 'v1.32.0'}
    Plug 'WhoIsSethDaniel/mason-tool-installer.nvim', {'commit': '1255518cb067e038a4755f5cb3e980f79b6ab89c'}
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    " Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'dmitmel/cmp-cmdline-history'
    Plug 'ray-x/cmp-treesitter'
    Plug 'lukas-reineke/cmp-rg'
    Plug 'davidsierradz/cmp-conventionalcommits'
    Plug 'anhpt379/cmp-mocword' | Plug 'anhpt379/plenary.nvim'
    Plug 'nvimtools/none-ls.nvim' | Plug 'anhpt379/plenary.nvim'
    Plug 'ray-x/cmp-treesitter'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'RRethy/nvim-treesitter-endwise'

    Plug 'lewis6991/gitsigns.nvim' | Plug 'anhpt379/plenary.nvim'

    Plug 'folke/trouble.nvim' | Plug 'kyazdani42/nvim-web-devicons'

    Plug 'sbdchd/neoformat'
    Plug 'pechorin/any-jump.vim'

    " Fix nvim not responding when opening typescript files
    " https://www.reddit.com/r/vim/comments/jm218c/comment/ghddi8p/
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'othree/yajs.vim'

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
    Plug 'nvim-treesitter/nvim-treesitter-textobjects'
    Plug 'SmiteshP/nvim-navic'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'm-demare/hlargs.nvim'

    Plug 'anhpt379/conflict-marker.vim'
    Plug 'andymass/vim-matchup'
    Plug 'inkarkat/vim-EnhancedJumps' | Plug 'inkarkat/vim-ingo-library'

    Plug 'tpope/vim-obsession'

    Plug 'wakatime/vim-wakatime'
  endif

call plug#end()

if g:hostname =~# 'fedora'
  " Enables the experimental Lua module loader to speed up startup time
  " (by about 20%)
  lua vim.loader.enable()
endif

" Use filetype.lua instead of filetype.vim
" https://github.com/neovim/neovim/pull/16600
let g:do_filetype_lua = 1
let g:did_load_filetypes = 0

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

" Make mouse scrolling smoother, by scroll one line at a time.
" (and also fix unexpected horizontally scrolling when using trackpad)
set mousescroll=ver:1,hor:0

" Scroll screen-lines (long/wrapped) instead of text lines
set smoothscroll

set pumblend=20
set cursorline

" Change vim command line cursor shape to vertical bar
set guicursor=i-c-ci-v:ver25

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
set textwidth=80
set colorcolumn=+1

" Make the keyboard faaaaaaast
set ttimeoutlen=5

set fillchars+=vert:\ "White space at the end

" Fix slow Gstatus
" https://github.com/tpope/vim-fugitive/issues/1176
" This also speeds up everything, vim becomes much faster after this change
set shell=/bin/bash
set shellcmdflag=-c

" Fix nvim not responding when opening typescript files
" https://www.reddit.com/r/vim/comments/jm218c/comment/ghddi8p/
augroup typescript
  autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.typescriptreact
augroup end

" Tweak for Markdown mode
augroup markdown
  autocmd FileType markdown call s:markdown_mode_setup()
augroup end

function! s:markdown_mode_setup()
  set wrap
  set textwidth=80
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

" Persistent undo & searches
set undofile
set undodir=~/.local/state/nvim/undo
set shada=!,'5000,<2500,s500,h
set shadafile=~/.local/state/nvim/shada/main.shada

" Searching and substitution {{{
set ignorecase
set smartcase

" Clear search highlighting by pressing Enter/Esc
nnoremap <CR>  :nohlsearch<CR>
nnoremap <Esc> :nohlsearch<CR><Esc>

" Live substitution
set inccommand=split
" }}}

" Change the leader from \ to <Space>
let mapleader=' '
noremap <Space> <Nop>

" Quickly reload nvim config & update plugins by pressing `<Leader>u`
nnoremap <Leader>u :source ~/.config/nvim/init.vim<CR>
  \ :TSUpdate<CR>
  \ :PlugClean<CR>
  \ :silent! PlugInstall<CR>
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
set formatoptions-=tc

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

	let location = luaeval("require'nvim-navic'.is_available()") ?
    \ luaeval("require'nvim-navic'.get_location()") : ''

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
if g:hostname =~# 'fedora'
  set showtabline=2

  map <C-n> :<C-u>execute 'normal gq' \| bnext<CR>
  map <C-p> :<C-u>execute 'normal gq' \| bprevious<CR>
  map <Up>  :<C-u>execute 'normal gq' \| bprevious<CR>
  nmap ` <C-^>

  let g:lightline#bufferline#show_number     = 0
  let g:lightline#bufferline#shorten_path    = 1
  let g:lightline#bufferline#unnamed         = '[No Name]'
  let g:lightline#bufferline#enable_devicons = 1
  let g:lightline#bufferline#unicode_symbols = 1
  let g:lightline#bufferline#modified        = ' '
  let g:lightline#bufferline#read_only       = ' 󰈡'
  let g:lightline#bufferline#clickable       = 1
  let g:lightline.separator                  = { 'left': '', 'right': '' }
  let g:lightline.subseparator               = { 'left': '', 'right': '' }

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

" Navigate diagnostics
" <C-jk> to jump between diagnostics
map <C-j> :lua vim.diagnostic.goto_next()<CR>
map <C-k> :lua vim.diagnostic.goto_prev()<CR>

" Jump to top/bottom of the file with <Home>/<End>
nmap <Home> gg
nmap <End> G
imap <Home> <ESC>I
imap <End> <ESC>A

" Jump to next/prev diagnostic from INSERT mode also
imap <silent> <PageDown> <Esc><PageDown>
imap <silent> <PageUp> <Esc><PageUp>

" No transparent auto-completion popup
set pumblend=0
set winblend=0

" Bclose
let g:bclose_no_plugin_maps = v:true

function! s:close_gstatus()
  " Get the total number of windows
  let l:total = winnr('$')
  " Loop backwards to avoid messing up winnr() ordering after closing
  for l:winnr in range(l:total, 1, -1)
    if l:total > 1 && !empty(getwinvar(l:winnr, 'fugitive_status'))
      execute l:winnr . 'close'
      let l:total -= 1
    endif
  endfor
endfunction

"##### Terminal apps #####
autocmd TermOpen  * if g:hostname =~# 'fedora' | set showtabline=0 | endif | set nonumber | set signcolumn=no  | set laststatus=0 | :DisableWhitespace
autocmd TermLeave * if g:hostname =~# 'fedora' | set showtabline=2 | endif | set number   | set signcolumn=yes | set laststatus=2 | :EnableWhitespace

function TermOpen(cmd, ...)
  let filepath = (a:0 >= 1 ? a:1 : '')

  set nowinfixbuf
  let callback = {}
  if !empty(filepath)
    let callback.filepath = filepath
  endif

  function! callback.on_exit(job_id, code, event)
    silent! Bclose!
    call s:close_gstatus()

    if has_key(self, 'filepath') && filereadable(self.filepath)
      let lines = readfile(self.filepath)
      for entry in lines
        let parts = split(entry, ':')
        if len(parts) >= 1 && filereadable(parts[0])
          execute 'edit ' . fnameescape(parts[0])
          if len(parts) >= 3 && str2nr(parts[1]) > 0 && str2nr(parts[2]) > 0
            call cursor(str2nr(parts[1]), str2nr(parts[2]))
          elseif len(parts) >= 2 && str2nr(parts[1]) > 0
            call cursor(str2nr(parts[1]), 1)
          endif
        endif
      endfor
    endif
  endfunction

  enew
  call termopen("printf '\e[5 q' && " . a:cmd, callback)
  startinsert
endfunction

function! FZF()
  call TermOpen('f', '/tmp/fzf_selected_files')
endfunction

function! FZFRg(is_visual) abort
  let l:query = ''

  if a:is_visual
    " Get visual selection text
    let l:start = getpos("'<")
    let l:end = getpos("'>")
    let l:lines = getline(l:start[1], l:end[1])
    if len(l:lines) == 1
      let l:query = strpart(l:lines[0], l:start[2] - 1, l:end[2] - l:start[2] + 1)
    else
      let l:lines[0] = strpart(l:lines[0], l:start[2] - 1)
      let l:lines[-1] = strpart(l:lines[-1], 0, l:end[2])
      let l:query = join(l:lines, ' ')
    endif
  endif

  " If still empty (normal mode or empty selection), ask for input
  if empty(l:query)
    let l:query = input('FZFRg> ')
  endif

  if !empty(l:query)
    call TermOpen('f "' . l:query . '"', '/tmp/fzf_selected_files')
  endif
endfunction

function! Lf()
  call TermOpen('echo "" > /tmp/lf_selected_files && lf --selection-path /tmp/lf_selected_files ' . expand('%:p'), '/tmp/lf_selected_files')
endfunction

nnoremap <silent> <leader>g :call FZFRg(v:false)<CR>
vnoremap <silent> <leader>g :<C-u>call FZFRg(v:true)<CR>
noremap <Leader>l :call Lf()<CR>
noremap <Leader>f :call FZF()<CR>

nnoremap gb :call TermOpen('gb')<CR>
nnoremap gl :call TermOpen('gl')<CR>
nnoremap gL :call TermOpen('gl ' . expand('%:p'))<CR>
vnoremap gl :call TermOpen('gl ' . expand('%:p') . ':' . line('.'))<CR>

"#########################

" Git {{{
noremap gr :execute 'G rebase -i --autosquash ' . system('git symbolic-ref --short HEAD') . '<CR>'
noremap ga :G absorb --and-rebase<CR>
noremap gs :tab Git<CR>gg4j
noremap <expr> gw &modified ? ':silent! Gwrite<CR>:update<CR>' : ''

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

nmap g[ :Start! git pull --rebase origin $(git default-branch)<CR>
nmap g] :Start! git push --force-with-lease origin HEAD<CR>:silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
nmap m  :Start! git checkout $(git default-branch) && git pull --rebase origin $(git default-branch)<CR>
nmap gB :G blame<CR>

function! FugitiveRetryCommit()
  let l:msgfile = '.git/COMMIT_EDITMSG'
  if filereadable(l:msgfile)
    " Get actual last commit message (no comments)
    let l:last_msg = join(systemlist('git log -1 --pretty=%B'), "\n")
    let l:last_msg = trim(l:last_msg)

    " Get previous edit message without comment lines
    let l:edit_msg = filter(readfile(l:msgfile), 'v:val !~ "^#"')
    let l:edit_msg = trim(join(l:edit_msg, "\n"))

    " Compare the actual messages
    if l:edit_msg !=# l:last_msg
      execute 'vertical Git commit --quiet --no-status --edit -F .git/COMMIT_EDITMSG'
      return
    endif
  endif

  " No failed commit detected → start fresh
  execute 'vertical Git commit --quiet --no-status'
endfunction

augroup fugitive-personal-key-mappings
  autocmd FileType fugitive nmap <buffer> r :<C-u>tab Git rebase -i <C-R>=expand('<cword>')<CR><CR>
  autocmd FileType fugitive nmap <buffer> p :bd!<CR>
        \ :Start git push origin HEAD --force-with-lease<CR>
        \ :silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
  autocmd FileType fugitive nmap <buffer> P :bd!<CR>
        \ :Start git push origin HEAD --force<CR>
        \ :silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
  autocmd FileType fugitive nmap <buffer> m
        \ :!if git branch -a \| grep remotes/ \| grep -q /$(git branch --show-current)$; test $? -eq 1; then
        \     git push --force-with-lease origin HEAD;
        \   fi<CR>
        \ :<C-u>call vim_git_browse#GitOpenPullRequest()<CR>
        \ :silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>

  " Verbose and quiet git commit by default
  autocmd FileType fugitive nmap <buffer> C  :call FugitiveRetryCommit()<CR>
  autocmd FileType fugitive nmap <buffer> cc :call FugitiveRetryCommit()<CR>
  autocmd FileType fugitive nmap <buffer> ca :vertical Git commit --quiet --no-status --amend<CR>
  autocmd FileType fugitive nmap <buffer> ce :Git commit --amend --quiet --no-status --no-edit<CR>

  " gw in gitcommit/gitrebase to save and close
  autocmd FileType gitcommit nmap <buffer> gw :x<CR>
  autocmd FileType gitrebase nmap <buffer> gw :x<CR>

  " Open diff in a new buffer by default
  autocmd FileType fugitive map <buffer> <nowait> <CR> O

  " Easier to reach -= keys
  autocmd FileType fugitive map <buffer> <nowait> d =
  autocmd FileType fugitive map <buffer> <nowait> a -

  " x is easier to type than X
  autocmd FileType fugitive map <buffer> <nowait> x X

  " gr to rebase
  autocmd FileType fugitive map <buffer> <nowait> gr :execute 'G rebase -i ' . system('git symbolic-ref --short HEAD') . '<CR>'

  " Left padding
  autocmd FileType fugitive set signcolumn=yes | set number

  " Open G blame commit with `go`
  autocmd FileType fugitiveblame nmap <buffer> go :.GBrowse<CR>
augroup end

augroup fugitive-auto-insert
  autocmd!
  autocmd BufEnter COMMIT_EDITMSG if empty(getline(1)) | startinsert | endif
  autocmd FileType gitrebase normal! 4G
augroup end
" }}}

" Use U as redo
nnoremap U <C-R>

" <C-c> (close) to save & close the current buffer
imap <C-c> <C-O>:x<CR>
nmap <C-c> :x<CR>

" Don't change the clipboard if paste over a visually selected text
xnoremap <expr> p 'pgv"' . v:register . 'y'

" Duplicate a line a comment out the first line
nmap yc yy<Leader>cp

" Keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" Use <Tab> and <S-Tab> to indent/outdent the code block
vmap <Tab> >gv
vmap <S-Tab> <gv

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
command! CPP :call system('pbcopy', fnamemodify(expand("%"), ":~:."))

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
setglobal commentstring=#\ %s
nmap <Leader>c gcc
vmap <Leader>c gc

" Vim-unimpaired custom mappings
nnoremap ]<Space> a <Esc>
nnoremap [<Space> i <Esc>
nnoremap ]<CR> o<Esc>
nnoremap [<CR> O<Esc>

" Join lines and restore cursor location (J)
nnoremap J mjJ`j

" Make it easier to increase/decrease values
map <Leader>= <C-a>
map <Leader>- <C-x>

" Copy LLM context to clipboard
nnoremap <C-y> :silent !gptree --no-config %:p:h && cat ~/.config/llm/base_prompt.md gptree_output.txt \| pbcopy && rm -f gptree_output.txt<CR>

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
let g:lexima_map_escape = ''
let g:lexima_enable_basic_rules = 0

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
  endif
endfunction

map q :<C-u>silent! call Goodbye()<CR>

" Close all buffers without saving
nnoremap <silent> Q :qa!<CR>

" Remap recording macro key to the delete key
" (I mapped the delete key to F20 in Karabiner)
nnoremap <F20> q

" Startify
let g:startify_disable_at_vimenter = 0
nmap <Leader>s :Startify<CR>

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
  \ {'b': '~/dotfiles/macOS/brew/.Brewfile'},
  \ {'f': '~/dotfiles/local/fish/.config/fish/config.fish'},
  \ {'t': '~/dotfiles/local/tmux/.tmux.conf'},
  \ {'v': '~/dotfiles/local/nvim/.config/nvim/init.vim'},
  \ ]

augroup startified
  autocmd User Startified setlocal cursorline
  autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
  autocmd User Startified nmap <buffer> q :q!<CR>
augroup end

function! StartifyEntryFormat()
  return "WebDevIconsGetFileTypeSymbol(absolute_path) . ' ' . entry_path"
endfunction

" Custom file extensions / syntax highlighting
augroup custom-file-extensions
  autocmd BufReadPost *.rules set filetype=yaml
  autocmd BufReadPost *.eyaml set filetype=yaml
augroup end

" Highlight yanked text
autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="TextYankPost", timeout=700}

" Conflict-marker {{{
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

let g:conflict_marker_enable_matchit = 1
let g:conflict_marker_enable_mappings = 1

" }}}

" Vim-better-whitespace
let g:strip_whitespace_on_save = 0
let g:strip_whitelines_at_eof = 1
let g:better_whitespace_operator = ''
let g:current_line_whitespace_disabled_soft = 1

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
set conceallevel=2

" }}}

" https://www.reddit.com/r/vim/comments/g1lx7e/i_made_a_command_to_autoformat_shell_commands/
command! -range FormatShellCmd <line1>!~/.config/nvim/bin/format_shell_cmd.py

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

" Line text objects
" https://vi.stackexchange.com/a/21238
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>

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

" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
" set diffopt+=indent-heuristic

" A faster way to toggle line number
map [n :<C-u>set nonumber<CR>
map ]n :<C-u>set number<CR>

" A faster way to toggle wrap
map [w :<C-u>set wrap!<CR>
map ]w :<C-u>set wrap!<CR>

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
let g:neoformat_enabled_terraform = ['terraform']

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

" Command-line mode: Ctrl-H → Home, Ctrl-L → End
cmap <C-h> <Home>
cmap <C-l> <End>

" Fix Control/Option+Backspace/Delete didn't work in vim command line
cnoremap        <M-BS> <C-w>
cnoremap <expr> <C-Del> &cedit. 'dW' .'<C-c><Space><BS>'
cnoremap <expr> <M-Del> &cedit. 'dw' .'<C-c><Space><BS>'

" Allow Control/Option+Backspace/Delete to delete words in insert mode
set backspace=indent,eol,start
inoremap <C-h>   <Left><C-o>dvB
inoremap <M-BS>  <Left><C-o>dvb
inoremap <C-Del> <C-o>dW
inoremap <M-d>   <C-o>dw

" Vim-fugitive GBrowse
let g:fugitive_gitlab_domains = ['https://gitlab.' . $COMPANY_DOMAIN]

function! BrowseWithDefaultBranch(bang) range
    let l:mode = visualmode()
    let l:branch = substitute(system('git default-branch'), '\n', '', 'g')
    if l:mode ==# 'v' || l:mode ==# 'V' || l:mode ==# "\<C-V>"
        execute "'<,'>GBrowse" . a:bang . ' ' . l:branch . ':%'
    else
        execute 'GBrowse' . a:bang . ' ' . l:branch . ':%'
    endif
endfunction

nnoremap <silent> go :call BrowseWithDefaultBranch('')<CR>
nnoremap <silent> gO :call BrowseWithDefaultBranch('!')<CR>
vnoremap <silent> go :<C-U>call BrowseWithDefaultBranch('')<CR>
vnoremap <silent> gO :<C-U>call BrowseWithDefaultBranch('!')<CR>

nnoremap <silent> gm :!if git branch -a \| grep remotes/ \| grep -q /$(git branch --show-current)$; test $? -eq 1; then
                   \     git push --force-with-lease origin HEAD;
                   \   fi<CR>
                   \ :Start! open $(~/.local/bin/gm)<CR>
                   \ :silent exec '!git rev-parse HEAD \| tr -d "\n" \| pbcopy'<CR>
nnoremap <silent> gM :Start! ~/.local/bin/gm \| pbcopy<CR>

" Suda & vim-eunuch
let g:suda_smart_edit = 1
let g:suda#try_without_password = !has('nvim')
command! SudoWrite w suda://%

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
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_confirm_unsaving_quit = 0
let g:ctrlsf_position = 'left'
let g:ctrlsf_indent = 2
let g:ctrlsf_auto_close = 0
let g:ctrlsf_auto_focus = { 'at' : 'start' }
let g:ctrlsf_auto_preview = 0
let g:ctrlsf_winsize = '100%'
let g:ctrlsf_backend = 'rg'
let g:ctrlsf_follow_symlinks = 0
let g:ctrlsf_search_mode = 'sync'
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

" Lsp
nmap gd       :lua vim.lsp.buf.declaration()<CR>
nmap gD       :lua vim.lsp.buf.definition()<CR>
nmap K        :lua vim.lsp.buf.hover()<CR>
nmap <Space>r :lua vim.lsp.buf.rename()<CR>

" Tree-sitter based folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Lua config
if g:hostname =~# 'fedora'
  luafile <sfile>:h/config.lua
endif

" Format code on file save
function! FormatCode()
  let file = expand('%:p')
  if !filewritable(file)
    return
  endif

  noautocmd write

  let script_file =
        \ system('git rev-parse --show-toplevel')[:-2] .
        \ '/scripts/format-' . &filetype . '.sh'
  if v:shell_error != 0 || !filereadable(script_file)
    return
  endif

  let output = system(script_file . ' ' . file)
  if v:shell_error == 0
    let view = winsaveview()
    edit
    call winrestview(view)
  else
    echo output
  endif
endfunction

augroup format_code_on_save
  autocmd BufWritePre *.tf,*.tfvars Neoformat
  autocmd BufWriteCmd *.pp call FormatCode()
  autocmd BufWriteCmd *.yaml,*.eyaml,*.yml call FormatCode()
augroup end

function! PuppetGoToDefinition()
  let isk_save = &l:isk

  " [Class['::foo::bar']], file('/path/to/file.sh'), $::is_staging
  " include ::profile_base
  setlocal iskeyword+=:,.,/,],[,',\",\$,-
  let cword = expand('<cword>')
  let &l:isk = isk_save

  let tag_name = cword

  " Removing single/double quotes, and `::` from the tag name
  let tag_name = substitute(tag_name, ':$', '', '')
  let tag_name = substitute(tag_name, '^"', '', '')
  let tag_name = substitute(tag_name, '"$', '', '')
  let tag_name = substitute(tag_name, "^'", '', '')
  let tag_name = substitute(tag_name, "'$", '', '')
  let tag_name = substitute(tag_name, '^::', '', '')
  let tag_name = substitute(tag_name, '^[', '', '')
  let tag_name = substitute(tag_name, ']]$', ']', '')

  echo tag_name
  exec('silent! tag ' . tag_name)
endfunction

augroup puppet_go_to_definition
  autocmd FileType puppet nmap <buffer> <C-]> :call PuppetGoToDefinition()<CR>
augroup end

augroup copy_text_to_clipboard_on_focus_lost
  autocmd BufLeave,FocusLost * silent! normal! ygv
augroup end
