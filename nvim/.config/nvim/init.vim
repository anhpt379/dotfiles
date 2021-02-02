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

  " Fancy UI stuff
  Plug 'anhpt379/fzf'
  Plug 'anhpt379/fzf.vim'
  Plug 'anhpt379/fzf-filemru'
  Plug 'Yggdroot/indentLine'
  Plug 'chrisbra/Colorizer'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'blueyed/vim-diminactive'
  Plug 'ryanoasis/vim-devicons'
  Plug 'machakann/vim-highlightedyank'
  Plug 'breuckelen/vim-resize'
  Plug 'ptzz/lf.vim'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'roman/golden-ratio'
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
  Plug 'brooth/far.vim'
  Plug 'farmergreg/vim-lastplace'
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
  Plug 'Vimjas/vim-python-pep8-indent'
  Plug 'kana/vim-niceblock'
  Plug 'haya14busa/vim-asterisk'
  Plug 'google/vim-searchindex'
  Plug 'junegunn/vim-after-object'
  Plug 'jeetsukumaran/vim-indentwise'

  " Heavily loaded plugins
  if has('mac')
    Plug 'dstein64/vim-startuptime'
    Plug 'mhinz/vim-startify'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'

    Plug 'anhpt379/vim-fugitive'
    Plug 'anhpt379/git-messenger.vim'
    Plug 'dinhhuy258/vim-git-browse'

    Plug 'anhpt379/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
    Plug 'nvim-treesitter/nvim-treesitter', {'commit': 'f84c93c'}

    Plug 'rhysd/conflict-marker.vim'
    Plug 'itchyny/vim-parenmatch'

    Plug 'wakatime/vim-wakatime'
  endif

call plug#end()


" Vim-startuptime
let g:startuptime_self = 1
let g:startuptime_more_info_key_seq = '<Space>'

" Open vim-plug in a new buffer
let g:plug_window = 'enew'

let g:coc_global_extensions = [
  \ 'coc-git',
  \ 'coc-python',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-fish',
  \ 'coc-markdownlint',
  \ 'coc-docker',
  \ 'coc-sh',
  \ 'coc-dictionary',
  \ 'coc-diagnostic',
  \ 'coc-vimlsp',
  \ 'coc-solargraph',
  \ 'coc-marketplace'
  \ ]

" coc-dictionary
set dictionary+=~/.config/nvim/dictionaries/hacker_news.txt

" ansible-vim
let g:ansible_attribute_highlight = 'ab'

" More natural split opening
set splitbelow
set splitright

" Enable mouse for all mode
set mouse=a

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
  \ :PlugClean<CR>
  \ :silent !PlugInstall<CR>
  \ :PlugUpdate --sync<CR>
  \ :CocUpdate<CR>
  \ :TSUpdate<CR>

" Turn off whitespaces compare and folding in vimdiff
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical

if has('mac')
  set clipboard=unnamed
endif

" JSON quote concealing
set conceallevel=2

" Disable auto wrap lines
set formatoptions-=t

" Lightline {{{

let g:lightline = {
  \ 'colorscheme': 'aodark',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['gitbranch', 'readonly', 'cocstatus', 'modified']
  \   ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'DevIconsFugitiveHead',
  \   'cocstatus': 'coc#status',
  \   'filetype': 'DevIconsFileType',
  \   'fileformat': 'DevIconsFileFormat',
  \ },
  \ }

function! DevIconsFugitiveHead()
  let branch = FugitiveHead()
  if empty(branch)
    return ''
  endif
  return ' ' . branch
endfunction

function! DevIconsFileType()
  return winwidth(0) > 70 ?
        \ (strlen(&filetype) ?
        \  WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
endfunction

function! DevIconsFileFormat()
  return winwidth(0) > 70 ?
        \ (WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat) : ''
endfunction

" Show vim tab line even if only one file is open
if has('mac')
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
  nmap <M-n> :bnext<CR>
  nmap <M-p> :bprevious<CR>

  let g:lightline#bufferline#show_number     = 2
  let g:lightline#bufferline#shorten_path    = 1
  let g:lightline#bufferline#unnamed         = '[No Name]'
  let g:lightline#bufferline#enable_devicons = 1
  let g:lightline#bufferline#unicode_symbols = 1
  let g:lightline#bufferline#modified        = ' '
  let g:lightline#bufferline#read_only       = ' '
  let g:lightline#bufferline#clickable       = 1

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


" Coc {{{
let g:coc_status_error_sign   = ' '
let g:coc_status_warning_sign = ' '
let g:coc_status_info_sign    = ' '

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
inoremap <expr> <CR> pumvisible() ? '\<C-y>' : '\<CR>'

" Navigate diagnostics
nmap <silent> <Tab> <Plug>(coc-diagnostic-prev)
nmap <silent> <S-Tab> <Plug>(coc-diagnostic-next)

" Jump to next/prev diagnostic from INSERT mode also
imap <silent> <C-n> <Esc><C-n>
imap <silent> <C-p> <Esc><C-p>

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

" Remap for do codeAction of selected region, ex: `<Leader>aap` for current
" paragraph
xmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <Leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <Leader>qf <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature
" of languageserver
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Add status line support, for integration with other plugin, checkout `:h
" coc-status`
if exists('g:did_coc_loaded')
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
endif

" No transparent auto-completion popup
set pumblend=0
set winblend=0

" }}}

" Fzf {{{
let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1
let g:fzf_layout = {'window': 'enew'}
let g:fzf_preview_window = ['right:60%', 'ctrl-/']
let g:fzf_commits_log_options = '
  \ -5000 --no-merges --color=always
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

noremap <M-Space> :GstatusClose<CR>:silent FilesMru<CR>
noremap <Leader>g :GstatusClose<CR>:FzfRg<Space>
noremap <Leader>l :GstatusClose<CR>:FzfLines<CR>
noremap <Leader>t :GstatusClose<CR>:FzfFiletypes<CR>
" }}}

" Git {{{
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_no_default_mappings = v:true
let g:git_messenger_include_diff = 'current'
let g:git_messenger_max_popup_height = 35
let g:git_messenger_max_popup_width = 120
let g:git_messenger_popup_type = 'preview'

" Don't blame people for changing whitespaces or moving code
let g:git_messenger_extra_blame_args = '-w -M'

augroup gitmessenger
  " Show line number in git-messenger popup
  autocmd FileType gitmessengerpopup set number

  " Close git-messenger popup with <Esc>
  autocmd FileType gitmessengerpopup nmap <buffer> <Esc> q
augroup end

noremap gm :GitMessenger<CR>
noremap gB :Gblame -w -M<CR>
noremap gs :tab Gstatus<CR>gg4j
noremap gl :FzfCommits<CR>
noremap gL :FzfBCommits<CR>
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

nmap g[ :Dispatch! noti git pull --rebase origin master<CR>
nmap g] :Dispatch! noti git push --force-with-lease origin HEAD<CR>:silent exec '!git rev-parse --short HEAD \| pbcopy'<CR>
nmap M  :Dispatch! noti 'git checkout master && git pull --rebase origin master'<CR>

augroup fugitive-personal-key-mappings
  autocmd FileType fugitive nmap <buffer> p :bd!<CR>
        \ :Dispatch! noti git push origin HEAD --force-with-lease<CR>
        \ :silent exec '!git rev-parse --short HEAD \| pbcopy'<CR>

  " Verbose and quiet git commit by default
  autocmd FileType fugitive nmap <buffer> C  :vertical Git commit --quiet --no-status<CR>
  autocmd FileType fugitive nmap <buffer> cc :vertical Git commit --quiet --no-status<CR>
  autocmd FileType fugitive nmap <buffer> ca :vertical Git commit --quiet --no-status --amend<CR>
  autocmd FileType fugitive nmap <buffer> ce :Git commit --amend --quiet --no-status --no-edit<CR>

  " gw in gitcommit to save and close
  autocmd FileType gitcommit nmap <buffer> gw :x<CR>

  " Open diff in a new buffer by default
  autocmd FileType fugitive map <buffer> <nowait> <CR> O

  " Easier to reach -= keys
  autocmd FileType fugitive map <buffer> <nowait> d =
  autocmd FileType fugitive map <buffer> <nowait> a -

  " x is easier to type than X
  autocmd FileType fugitive map <buffer> <nowait> x X
augroup end

augroup fugitive-auto-insert
  autocmd!
  autocmd BufEnter COMMIT_EDITMSG startinsert
augroup end
" }}}

" Remap recording macro key to `\` (`q` will be using as 'quit' to close the
" current buffer)
nnoremap \ q

" Use U as redo
nnoremap U <C-R>

" Use Ctrl+C as the ESC key
" Since ESC has 300ms delay due to Karabiner, so using Ctrl+C will be faster
imap <C-c> <Esc>

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
command! CopyPath let @+=expand('%:p')

" Insert mode navigational keys
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

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

" Use [c ]c to swap chars instead of xp and Xp
" This uses vim register a instead of the default one (system clipboard)
nnoremap ]c v"ax"ap
nnoremap [c hv"ax"aph

" Disable <BS>/<Del> in NORMAL mode
nnoremap <BS>  <nop>
nnoremap <Del> <nop>

" Quick folding with `-`
nnoremap - za
vnoremap - za

" Comment stuff out
nnoremap <Leader>/ :Commentary<CR>
vnoremap <Leader>/ :Commentary<CR>

" Join lines and restore cursor location (J)
nnoremap J mjJ`j

" Faster search & replace with <C-r>
map <C-u> <Plug>(RepeatRedo)
nnoremap <C-r> :%s/<C-r><C-w>//<Left>
vnoremap <C-r> "hy:%s/<C-r>h//<Left>

" Select the last pasted text with gp (similar to the standard gv which you can
" type to select the last visually-selected text)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Disable continuation of comments to the next line in Vim
augroup format-options
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup end

" Colorizer
lua require'colorizer'.setup()

" Lexima
let g:lexima_enable_basic_rules = 0
let g:lexima_map_escape = ''

" Sandwich
runtime macros/sandwich/keymap/surround.vim

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
nnoremap <silent> Q :q<CR>

" Startify
nmap <Leader><Leader> :Startify<CR>

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
  \ {'b': '~/dotfiles/Brewfile'},
  \ {'f': '~/dotfiles/fish/.config/omf/init.fish'},
  \ {'v': '~/dotfiles/nvim/.config/nvim/init.vim'},
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

" coc-yank
noremap <Leader>p :CocList --normal yank<CR>

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 700

if !has('mac')
  " Copy remote text yank to local clipboard
  augroup YankToLocalClipboard
    autocmd TextYankPost * call system('nc 127.0.0.1 2224 --send-only', @0)
  augroup end

  " Automatically jump to end of text you pasted
  vnoremap p :<C-u>set paste<CR>:let @a = system("nc 127.0.0.1 2225 --recv-only")<CR>"ap`]:set nopaste<CR>
  nnoremap p :set paste<CR>:let @a = system("nc 127.0.0.1 2225 --recv-only")<CR>"ap`]:set nopaste<CR>
  vnoremap P :<C-u>set paste<CR>:let @a = system("nc 127.0.0.1 2225 --recv-only")<CR>"aP`]:set nopaste<CR>
  nnoremap P :set paste<CR>:let @a = system("nc 127.0.0.1 2225 --recv-only")<CR>"aP`]:set nopaste<CR>

  " Don't change the clipboard if paste over a visually selected text
  xnoremap p "_d:set paste<CR>:let @a = system("nc 127.0.0.1 2225 --recv-only")<CR>"aP`]:set nopaste<CR>

  " Fix nvim on server x/X in VISUAL mode doesn't trigger TextYankPost
  if !has('mac')
    vnoremap x ygvx
    vnoremap X ygvX
  endif
endif

" Conflict-marker {{{
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

" }}}

" vim-better-whitespace
let g:strip_whitespace_on_save = 0
let g:strip_whitelines_at_eof = 1
let g:better_whitespace_operator = ''

nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

function! DisableWhitespace()
  if &ft =~# 'fugitive\|startify\|far\|git\|man'
    DisableWhitespace
  endif
endfunction

augroup disable-whitespace
  autocmd FileType * call DisableWhitespace()
augroup end

" vim indentline {{{
set listchars=tab:→\ ,extends:»,precedes:«
set list

let g:indentLine_char = '┊'

" Fix double quotes in json files went missing
augroup json
  autocmd InsertEnter *.json setlocal concealcursor=
  autocmd InsertLeave *.json setlocal concealcursor=inc
augroup end

" Hide fzf status line
augroup fzf
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler |
    \ autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup end

function! DisableIndentLines()
  if &ft =~# 'fzf\|startify\|man'
    IndentLinesDisable
  endif
endfunction

augroup indentlines
  autocmd FileType * call DisableIndentLines()
augroup end
" }}}

" vim-diminactive
let g:diminactive_filetype_blacklist = []
let g:diminactive_buftype_blacklist = []
let g:diminactive_use_syntax = 1
let g:diminactive_use_colorcolumn = 0

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

" Jump to start and end of line using the home row keys
map H :call ToggleHomeZero()<CR>
map L $
map <Home> :call ToggleHomeZero()<CR>
map <End>  $

" Moving up/down faster with <C-k>/<C-j>
" (<C-k>/<C-j> is PageUp/PageDown due to mappings in Karabiner)
nnoremap <PageUp>   2k
nnoremap <PageDown> 2j

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

" Far.vim {{{
let g:far#window_layout = 'tab'
let g:far#preview_window_height = '15'
let g:far#enable_undo = 1
let g:far#default_file_mask = '*'
let g:far#source = 'rgnvim'

" Fix `q` quit far doesn't work properly
let g:far#mapping = {
  \ 'quit' : ''
  \ }

" Far search and replace with dir completion
command! -complete=dir -nargs=+ -range=-1 Fr
  \ call Far(<count>,<line1>,<line2>,<q-args>)

" }}}

" Lf.vim
let g:lf_map_keys = 0
let g:lf_replace_netrw = 1
autocmd TermEnter * if has("mac") | set showtabline=0 | endif | set nonumber | set signcolumn=no  | set mouse-=a | IndentLinesDisable
autocmd TermLeave * if has("mac") | set showtabline=2 | endif | set number   | set signcolumn=yes | set mouse+=a
map <Leader>f :<C-u>Lf<CR>

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
map [n :<C-u>set nonumber<CR>
map ]n :<C-u>set number<CR>

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

command! FormatCode silent! Neoformat

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

" Don't use the "smart" yaml indentation detection. It doesn't work in
" kubernetes-related yaml files, since they are using YAML list with `-` on the
" same indent level as the parent.
" Also, this will fix the wrong indentation detection in Vim 7.4 (the version
" on my servers)
augroup yaml
  autocmd FileType yaml set indentexpr=
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

" Treesitter
if exists('g:loaded_nvim_treesitter')
  lua require'nvim-treesitter.configs'.setup{ ensure_installed='all', highlight={ enable=true } }
endif

" Vim-git-browse
let g:vim_git_browse_use_default_keymap = 0
nnoremap <silent> go :<C-u>call vim_git_browse#GitBrowse(v:false)<CR>
xnoremap <silent> go :<C-u>call vim_git_browse#GitBrowse(v:true)<CR>
nnoremap <silent> g\ :<C-u>call vim_git_browse#GitOpenPullRequest()<CR>

" LanguageTool
" Disable vim <C-n>/<C-p> complete in INSERT mode, since we have coc-dictionary
" already
imap <C-n> <Esc><C-n>
imap <C-p> <Esc><C-p>

" Suda & vim-eunuch
let g:suda_smart_edit = 1
let g:suda#try_without_password = !has('nvim')
command! SudoWrite w suda://%

" Floaterm
let g:floaterm_shell = '/usr/local/bin/fish'
let g:floaterm_wintype = 'split'
let g:floaterm_autoclose = 1
let g:floaterm_open_in_root = v:true

augroup floaterm
  autocmd User Startified setlocal buflisted
augroup end

nnoremap gb :FloatermNew gb<CR>

" Vim-after-object: change/delete/select text *after* a character
augroup vim-after-object
  autocmd VimEnter * silent! call after_object#enable(['a', 'A'], '=', ':', '#', ' ', '|', '*')
augroup end

" ]i and [i to go to next/previous indentation level
nmap <silent> ]i <Plug>(IndentWiseNextGreaterIndent)
nmap <silent> [i <Plug>(IndentWisePreviousLesserIndent)

" gg in VISUAL mode to perform google I'm feeling lucky search on the selected text
function! GoogleSearchImFeelingLucky()
  let searchterm = getreg('g')
  silent! exec 'silent! !open "http://www.google.com/search?sourceid=navclient&gfns=1&q=' . searchterm . '" &'
endfunction
vnoremap gg "gy<Esc>:call GoogleSearchImFeelingLucky()<CR>

" ENTER in VISUAL mode to start EasyAlign
vmap <Enter> <Plug>(EasyAlign)
