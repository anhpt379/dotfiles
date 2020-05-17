scriptencoding utf-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()
  " Profiler
  Plug 'dstein64/vim-startuptime'

  " Defaults everyone can agree on
  Plug 'tpope/vim-sensible'

  " Changes Vim working directory to project root
  Plug 'airblade/vim-rooter'

  " Some Git stuff
  Plug 'tpope/vim-fugitive'
  Plug 'rhysd/git-messenger.vim'
  Plug 'ruanyl/vim-gh-line'
  Plug 'tommcdo/vim-fugitive-blame-ext'

  " EditorConfig
  Plug 'editorconfig/editorconfig-vim'

  " LSP support
  Plug 'anhpt379/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

  " Syntax highlighting
  Plug 'gisphm/vim-gitignore'
  Plug 'chr4/nginx.vim'
  Plug 'glench/vim-jinja2-syntax'
  Plug 'ekalinin/Dockerfile.vim'
  Plug 'rodjek/vim-puppet'
  Plug 'pearofducks/ansible-vim'
  Plug 'cespare/vim-toml'
  Plug 'mechatroner/rainbow_csv'
  Plug 'ericpruitt/tmux.vim'
  Plug 'georgewitteman/vim-fish'
  Plug 'CH-DanReif/haproxy.vim'
  Plug 'towolf/vim-helm'
  Plug 'MTDL9/vim-log-highlighting'
  Plug 'wgwoods/vim-systemd-syntax'
  Plug 'Guzzii/python-syntax'
  Plug 'vim-ruby/vim-ruby'

  " Fancy UI stuff
  Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFind', 'NERDTreeClose']}
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
  Plug 'junegunn/fzf.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'mhinz/vim-startify'
  Plug 'atimholt/spiffy_foldtext'
  Plug 'pseewald/vim-anyfold'
  Plug 'Nudin/vim-indentguides'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'xolox/vim-misc'
  Plug 'blueyed/vim-diminactive'
  Plug 'ryanoasis/vim-devicons'
  Plug 'rhysd/conflict-marker.vim'
  Plug 'machakann/vim-highlightedyank'
  Plug 'breuckelen/vim-resize'

  " Improving editing experience
  Plug 'wellle/targets.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'tpope/vim-repeat'
  Plug 'inkarkat/vim-visualrepeat'
  Plug 'machakann/vim-sandwich'
  Plug 'tpope/vim-commentary'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'brooth/far.vim'
  Plug 'farmergreg/vim-lastplace'
  Plug 'lambdalisue/suda.vim'
  Plug 'tpope/vim-unimpaired'
  Plug 'rhysd/clever-f.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'cohama/lexima.vim'
  Plug 'Konfekt/vim-CtrlXA'
  Plug 'tpope/vim-speeddating'
  Plug 'tpope/vim-dispatch'
  Plug 'Asheq/close-buffers.vim'
  Plug 'chaoren/vim-wordmotion'

  " Time tracking
  Plug 'wakatime/vim-wakatime'

call plug#end()

let g:coc_global_extensions = [
  \ 'coc-prettier',
  \ 'coc-git',
  \ 'coc-python',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-fish',
  \ 'coc-markdownlint',
  \ 'coc-yaml',
  \ 'coc-docker',
  \ 'coc-sh',
  \ 'coc-dictionary',
  \ 'coc-emoji',
  \ 'coc-diagnostic',
  \ 'coc-vimlsp',
  \ 'coc-solargraph',
  \ 'coc-yank',
  \ 'coc-marketplace'
  \ ]

" coc-dictionary
set dictionary+=~/.config/nvim/dictionaries/hacker_news.txt

" ansible-vim
let g:ansible_attribute_highlight = 'ab'

" far.vim
let g:far#source = 'rgnvim'

" More natural split opening
set splitbelow
set splitright

" Enable mouse for all mode
set mouse=a

set pumblend=20
set cursorline

set foldmethod=indent
set foldlevel=99

let g:is_posix = 1

set noswapfile
set nojoinspaces
set nowrap

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

set smartindent

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

" Clear search/clever-f highlighting by pressing Enter
nnoremap <CR> :<C-u>nohlsearch<CR><Left><Right>

" Live substitution
set inccommand=split
" }}}

" Change the leader from \ to <Space>
let mapleader=' '

" Quickly reload nvim config & update plugins by pressing `<Leader>u`
nnoremap <Leader>u :w<CR>:source ~/dotfiles/nvim/.config/nvim/init.vim<CR>:PlugClean<CR>:silent !PlugInstall<CR>:source ~/dotfiles/nvim/.config/nvim/init.vim<CR>:PlugUpdate<CR>

" Turn off whitespaces compare and folding in vimdiff
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical

set clipboard=unnamed

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
  return ' ' . FugitiveHead()
endfunction

function! DevIconsFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
endfunction

function! DevIconsFileFormat()
  return winwidth(0) > 70 ? (WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat) : ''
endfunction

" Show vim tab line even if only one file is open
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

let g:lightline#bufferline#show_number      = 2
let g:lightline#bufferline#shorten_path     = 1
let g:lightline#bufferline#unnamed          = '[No Name]'
let g:lightline#bufferline#enable_devicons  = 1

let g:lightline#bufferline#number_map = {
  \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
  \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
  \ }

let g:lightline.tabline          = {'left': [['buffers']], 'right': []}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" }}}


" Coc {{{

highlight CocFloating guibg=#4D5565
highlight CocErrorHighlight guifg=#e06c75
highlight CocWarningHighlight guifg=#e5c07b

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
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

" Navigate diagnostics
nmap <silent> <Tab> <Plug>(coc-diagnostic-next)
nmap <silent> <S-Tab> <Plug>(coc-diagnostic-prev)

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

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')

  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" Remap for do codeAction of selected region, ex: `<Leader>aap` for current
" paragraph
xmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>a <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <Leader>ac <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <Leader>qf <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of
" languageserver
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold   :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h
" coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" No transparent auto-completion popup
set pumblend=0
set winblend=0

" }}}

" Some custom style
highlight NonText guifg=bg

" Fzf {{{
let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_commits_log_options = '-5000 --color=always --format="%C(auto)%h%d %C(blue)%aN%C(reset) %s (%cr)"'

command! -bang -nargs=* FzfRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git" '.<q-args>.' || true', 1,
  \   fzf#vim#with_preview({'options': ['--no-multi', '--layout=reverse']}), <bang>0)

" Fzf + devicons
function! Fzf_files_with_dev_icons(command)
  let l:fzf_files_options = '--preview "bat --color=always --style=numbers {2..} | head -'.&lines.'"'

  function! s:edit_devicon_prepended_file(item)
    let l:file_path = a:item[4:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
    \ 'source': a:command.' | devicon-lookup',
    \ 'sink':   function('s:edit_devicon_prepended_file'),
    \ 'options': l:fzf_files_options
    \ })
endfunction

function! CloseGstatus()
	for l:winnr in range(1, winnr('$'))
		if !empty(getwinvar(l:winnr, 'fugitive_status'))
			execute l:winnr.'close'
		endif
	endfor
endfunction

noremap <Leader>g :call CloseGstatus()<CR>:NERDTreeClose<CR>:FzfRg<Space>
noremap <Leader>f :call CloseGstatus()<CR>:NERDTreeClose<CR>:call Fzf_files_with_dev_icons($FZF_DEFAULT_COMMAND)<CR>
noremap <Leader>l :call CloseGstatus()<CR>:NERDTreeClose<CR>:FzfLines<CR>
noremap <Leader>c :call CloseGstatus()<CR>:NERDTreeClose<CR>:FzfCommits<CR>
" }}}

" Hybrid line numbers
augroup number-toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup end

" Git {{{
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_no_default_mappings = v:true

highlight gitmessengerPopupNormal guibg=#333333
highlight link gitmessengerHeader Identifier
highlight link gitmessengerHash Number
highlight link gitmessengerHistory Constant

noremap gm :GitMessenger<CR>
noremap gb :Gblame<CR>
noremap gs :NERDTreeClose<CR>:vertical Gstatus<CR>
noremap gl :NERDTreeClose<CR>:FzfBCommits<CR>
noremap gw :w<CR>:Gwrite<CR>
noremap gc :NERDTreeClose<CR>:Gwrite<CR>:vertical Gcommit -v<CR>
command! Gp Dispatch! git push origin HEAD --force-with-lease

" Close git-messenger popup with <Esc>
augroup git-messenger
  autocmd FileType gitmessengerpopup nmap <buffer> <Esc> q
augroup end
" }}}

" Remap recording macro key to `\` (`q` will be using as 'quit' to close the
" current buffer)
nnoremap \ q

" Record into register 'q', playback with 'Q'
nnoremap Q @q

" Use U as redo
nnoremap U <C-R>

" Saving quicker
nnoremap <C-S> :w<CR>
inoremap <C-S> <Esc>:w<CR>i

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

" Allow saving of files as sudo when I forgot to start vim using sudo
" `:w !sudo tee % > /dev/null` trick does not work on neovim
command! W w suda://%

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

" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, as I don't have to press the Shift key to form chords to
" enter ex mode
nnoremap ; :

" These are to cancel the default behavior of d, D, c, C, s to put the text they
" delete in the default register
" Note that this means e.g. "ad won't copy the text into register a anymore,
" you have to explicitly yank it
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
nnoremap <C-r> :%s/\V
vnoremap <C-r> "hy:%s/<C-r>h//g<Left><Left>

" Select the last pasted text with gp (similar to the standard gv which you can
" type to select the last visually-selected text)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Any-fold
let g:anyfold_fold_display = 0
let g:anyfold_fold_comments = 1
highlight Folded term=NONE cterm=NONE guibg=#333843

augroup anyfold
  autocmd!
  autocmd Filetype * AnyFoldActivate
augroup end

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

" Close buffer / vim with a single keypress {{{
function! CloseOnLast()
    let cnt = 0

    for i in range(0, bufnr("$"))
        if buflisted(i)
            let cnt += 1
        endif
    endfor

    if cnt <= 1
        q!
    else
        bd!
    endif
endfunction

nnoremap q :silent! call CloseOnLast()<CR>

" Quickly close several buffers at once
nnoremap <silent> Q :Bdelete! menu<CR>

" CtrlXA
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)

" Startify
nmap <Leader>s :NERDTreeClose<CR>:Startify<CR>

let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1

let g:startify_lists = [
  \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
  \ { 'header': ['   Bookmarks'],      'type': 'bookmarks'},
  \ { 'header': ['   Sessions'],       'type': 'sessions' },
  \ ]

let g:startify_bookmarks = [
  \ {'c': '~/dotfiles/nvim/.config/nvim/init.vim'},
  \ {'b': '~/dotfiles/Brewfile'},
  \ ]

autocmd User Startified setlocal cursorline
autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)

" Custom file extensions / syntax highlighting
autocmd BufReadPost *.rules set filetype=yaml
autocmd BufReadPost *.eyaml set filetype=yaml

" No magic search by default
map / /\V
map ? ?\V

" Vim wordmotion
nmap cw ce
nmap cW cE
onoremap W :<C-U>normal! vWh<CR>
let g:wordmotion_extra = ['[0-9a-fA-F]\{6}']   " hex colors

" coc-yank
noremap <Leader>p :CocList --normal yank<CR>

" vim-highlightedyank
let g:highlightedyank_highlight_duration = 700
highlight HighlightedyankRegion term=bold ctermbg=0 guibg=#e5c07b guifg=#ffffff

" Conflict-marker {{{
let g:conflict_marker_highlight_group = ''

" Include text after begin and end markers
let g:conflict_marker_begin = '^<<<<<<< .*$'
let g:conflict_marker_end   = '^>>>>>>> .*$'

highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerSeparator guifg=#e5c07b
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
" }}}

" vim-better-whitespace
let g:strip_whitespace_on_save  = 0
let g:strip_whitelines_at_eof = 1
let g:better_whitespace_operator = ''

nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

autocmd FileType fugitive DisableWhitespace
autocmd FileType startify DisableWhitespace
autocmd FileType far DisableWhitespace
autocmd FileType git DisableWhitespace

" vim-gh-line
let g:gh_gitlab_domain = "gitlab.booking.com"
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0
let g:gh_line_map = 'go'
let g:gh_repo_map = 'gr'

" vim-indentguides {{{
" space indents are visually identified by the "┆" character,
" while tabs are distinguished by "|"
set listchars=tab:\|\ ,

" Fix double quotes in json files went missing
let g:indentguides_concealcursor_unaltered = 1
" }}}

" vim-diminactive
let g:diminactive_filetype_blacklist = []
let g:diminactive_buftype_blacklist = []

" https://www.reddit.com/r/vim/comments/g1lx7e/i_made_a_command_to_autoformat_shell_commands/
command! -range FormatShellCmd <line1>!~/.config/nvim/bin/format_shell_cmd.py

" Format json
command! FormatJSON call CocAction('format')

" NerdTree {{{
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeShowFiles = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeIgnore = [
  \ '\.DS_Store',
  \ '\~$',
  \ '\.swp',
  \ '\.git$',
  \ '__pycache__',
  \ '\.pyc$'
  \ ]

let g:NERDTreeAutoDeleteBuffer = 1

" Use a single click to fold/unfold directory and a double click to open file
let g:NERDTreeMouseMode = 2

let g:NERDSpaceDelims = 1

let g:NERDTreeShowLineNumbers = 1

" Fix can't open Gstatus by pressing `gs` in NERDTree window
let g:NERDTreeMapOpenVSplit = ''

" Fix broken CursorLine highlighting nvim
" https://github.com/neovim/neovim/issues/9019
highlight NERDTreeFile ctermfg=14

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Jump to the current file on open
function! NerdTreeToggleFind()
    if exists("g:NERDTree") && g:NERDTree.IsOpen()
        NERDTreeClose
    elseif filereadable(expand('%'))
        NERDTreeFind
    else
        NERDTree
    endif
endfunction

nmap <Leader>n :call NerdTreeToggleFind()<CR>
" }}}

" Vim Devicons {{{
let g:DevIconsEnableFoldersOpenClose = 1

augroup NERDTreeConcealBrackets
  autocmd!
  autocmd FileType nerdtree syntax match HideBracketsInNerdTree "\]" contained conceal containedin=ALL
  autocmd FileType nerdtree syntax match HideBracketsInNerdTree "\[" contained conceal containedin=ALL
  autocmd FileType nerdtree setlocal conceallevel=3
  autocmd FileType nerdtree setlocal concealcursor=nvic
augroup end

augroup NERDTreeHideDirSlashes
	autocmd!
	autocmd FileType nerdtree syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
augroup end
" }}}

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

" Move word-by-word with option+left/right
nmap <M-Right> w
nmap <M-Left> b

" Press `0` repeatedly to toggle between `^` and `0`
" (`0` is easier to reach than `^`)
function! ToggleHomeZero()
  let pos = getpos('.')
  execute "normal! ^"
  if pos == getpos('.')
    execute "normal! 0"
  endif
endfunction
nnoremap 0 :call ToggleHomeZero()<CR>

" Easier change list jumps
nnoremap cp g;
nnoremap cn g,
