scriptencoding utf-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()

" Defaults everyone can agree on
Plug 'tpope/vim-sensible'

" Changes Vim working directory to project root
Plug 'airblade/vim-rooter'

" Some Git stuff
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'rhysd/git-messenger.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'ruanyl/vim-gh-line'

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
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'anhpt379/nerdtree-grep-plugin'
Plug 'liuchengxu/vista.vim'
Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-startify'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'voldikss/vim-floaterm'
Plug 'lifepillar/vim-cheat40'
Plug 'atimholt/spiffy_foldtext'
Plug 'pseewald/vim-anyfold'
Plug 'thaerkh/vim-indentguides'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'xolox/vim-notes'
Plug 'xolox/vim-misc'
Plug 'blueyed/vim-diminactive'
Plug 'ptzz/lf.vim'
Plug 'rbgrouleff/bclose.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'rhysd/conflict-marker.vim'

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

" Vim Devicons {{{
let g:DevIconsEnableFoldersOpenClose = 1

" Add 1 more space after icons in NERDTree
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

" Keep folder icon color the same with text
highlight! link NERDTreeFlags NERDTreeDir

" Add 1 more space after icons in Startify screen
let g:webdevicons_enable_startify = 0
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ."  ". entry_path'
endfunction
" }}}

" Vertical bar cursor shape by default
set guicursor=n-v-c-sm:ver25,i-ci-ve:ver25,r-cr-o:hor20

set mouse=a   " enable mouse for all mode
set pumblend=20
set cursorline

set foldmethod=indent
set foldlevel=99

let g:is_posix = 1

set noswapfile
set nojoinspaces
set nowrap
set termguicolors    " enable 24bit true color
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

" vnoremap <M-/> <Esc>/\%V
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

colorscheme onehalfdark

set whichwrap+=<,>,h,l

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab     " Insert spaces when Tab is pressed

set smartindent

set autowrite     " Automatically :write before running commands

" Persistent undo
set undofile
set undodir=~/.config/nvim/undo

" NerdTree {{{
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowFiles = 1
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore = [
  \ '\.DS_Store',
  \ '\~$',
  \ '\.swp',
  \ '\.git$',
  \ '__pycache__',
  \ '\.pyc$'
  \ ]

let NERDTreeAutoDeleteBuffer = 1

" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1

" Use a single click to fold/unfold directory and a double click to open file
let NERDTreeMouseMode=2

let g:NERDSpaceDelims = 1

let NERDTreeShowLineNumbers = 1
autocmd FileType nerdtree setlocal relativenumber
" }}}


" Searching and substitution {{{

set ignorecase
set smartcase

" Clear search highlighting by pressing Enter
nnoremap <CR> :<C-u>nohlsearch<CR>

" Live substitution
set inccommand=split

" }}}

" Change the leader from \ to <Space>
let mapleader=' '

" Quickly reload nvim config & update plugins by pressing `<Leader>u`
nnoremap <Leader>u :w<CR>:source ~/dotfiles/nvim/.config/nvim/init.vim<CR>:PlugClean<CR>:PlugInstall<CR>:source ~/dotfiles/nvim/.config/nvim/init.vim<CR>:PlugUpdate<CR>

" lf.vim
let g:lf_map_keys = 0

let g:NERDTreeHijackNetrw = 0
let g:lf_replace_netrw = 1
let g:lf_command_override = "lf -command 'set hidden; cmd open $floaterm $f'"

" Floating terminal {{{
let g:floaterm_open_in_root = v:true
let g:floaterm_position     = 'center'

highlight FloatermNF guibg=dark
highlight FloatermBorderNF guibg=dark

augroup floaterm-startify-fix
  autocmd User Startified setlocal buflisted
augroup end

" Open lf in Floaterm
nnoremap <Leader>l :FloatermNew lf -command 'set hidden; cmd open $floaterm $f'<CR>

" Open a floating terminal with <Leader>t
nnoremap <Leader>t :FloatermToggle<CR>

" Toggle floating terminal with Esc
tnoremap <Esc> <C-\><C-n>:FloatermToggle<CR>
" }}}

" Turn off whitespaces compare and folding in vimdiff
set splitright
silent! set splitvertical
set diffopt+=iwhite
set diffopt+=vertical

set clipboard=unnamed

" JSON quote concealing
set conceallevel=2

" Lightline {{{

let g:lightline = {
  \ 'colorscheme': 'onehalfdark',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['gitbranch', 'readonly', 'cocstatus', 'modified']
  \   ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name',
  \   'cocstatus': 'coc#status'
  \ },
  \ }

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
" let g:lightline#bufferline#filename_modifier = ':t'

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

" Use tab for trigger completion with characters ahead and navigate
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin
inoremap <silent><expr> <Tab>
  \ pumvisible() ? coc#_select_confirm() :
  \ <SID>check_back_space() ? "\<Tab>" :
  \ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

" Don't exit INSERT mode when pressing Esc to close auto-completion popup
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current
" position
" Coc only does snippet and additional edit on confirm
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <CR> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

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

" Remap for rename current word
" nmap <Leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <Leader>f <Plug>(coc-format-selected)
" nmap <Leader>f <Plug>(coc-format-selected)

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

" Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

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
highlight NonText guifg=#354751
highlight LineNr guibg=NONE
highlight CursorLineNr guibg=#313640

" LeaderF
highlight Lf_hl_popup_window guibg=#3F4653
highlight Lf_hl_cursorline guifg=#e5c07b
highlight Lf_hl_match guifg=#98c379
highlight Lf_hl_popup_prompt guifg=#ffcd4a
highlight Lf_hl_popup_inputText guibg=#4D5565
highlight Lf_hl_matchRefine guifg=#c678dd
highlight Lf_hl_popup_total guifg=#282c34 guibg=#dcdfe4
highlight Lf_hl_popup_lineInfo guifg=#dcdfe4 guibg=#5D6779
highlight Lf_hl_rgHighlight guibg=#e5c07b guifg=#282c34

let g:Lf_HideHelp = 1
let g:Lf_PopupShowStatusline = 1
let g:Lf_IgnoreCurrentBufferName = 0

let g:Lf_DefaultMode = 'NameOnly'
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_RecurseSubmodules = 1

let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = {'left': '', 'right': ''}

let g:Lf_ShortcutF = '<Leader>f'

command! -bang -nargs=* -complete=file LeaderfRg exec printf("Leaderf<bang> rg --nowrap --match-path --smart-case --fixed-strings %s", escape('<args>', '\\'))

noremap <Leader>b :LeaderfBufferAll<CR>
noremap <Leader>r :LeaderfMruCwd<CR>
noremap <Leader>g :LeaderfRg<Space>
noremap <Leader>h :Leaderf! rg --nowrap --match-path --smart-case --recall<CR>

let g:Lf_MruWildIgnore = {
  \ 'dir': ['.svn', '.git', '.hg']
  \ }

let g:Lf_CommandMap = {
  \ '<C-j>': ['<Tab>', '<C-j>'],
  \ '<C-k>': ['<S-Tab>', '<C-k>'],
  \ '<Left>': ['<C-h>'],
  \ '<Right>': ['<C-l>']
  \ }

let g:Lf_NormalMap = {
  \ 'Rg': [
  \     ['<Esc>', ':exec g:Lf_py "rgExplManager.quit()"<CR>'],
  \     ['i', ':exec g:Lf_py "rgExplManager.input()"<CR>']
  \   ]
  \ }

let g:Lf_RgConfig = [
  \ '--glob=!.git/*',
  \ '--hidden'
  \ ]

let g:Lf_PreviewResult = {
  \ 'File': 0,
  \ 'Buffer': 0,
  \ 'Mru': 0,
  \ 'Tag': 0,
  \ 'BufTag': 0,
  \ 'Function': 0,
  \ 'Line': 1,
  \ 'Colorscheme': 0,
  \ 'Rg': 0,
  \ 'Gtags': 0
  \ }

" Vista {{{
let g:vista_icon_indent = ['└ ', '├ ']
let g:vista_default_executive = 'coc'
let g:vista_sidebar_position = 'vertical topleft'
let g:vista_echo_cursor_strategy = 'scroll'
let g:vista_cursor_delay = 1
let g:vista_close_on_jump = 1
let g:vista_disable_statusline = 1

" Ensure you have installed some decent font to show these pretty symbols, then
" you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it
" as you wish.
let g:vista#renderer#icons = {
  \ 'function': '\uf794',
  \ 'variable': '\uf71b',
  \ }

" Preview markdown TOC (table of contents) with Remarkable
" npm install --save markdown-toc
let g:vista_executive_for = {
  \ 'markdown': 'toc',
  \ }

" Toggle Vista view window
nnoremap <Leader>v :Vista!!<CR>

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

highlight gitmessengerPopupNormal guibg=#3F4653
highlight link gitmessengerHeader Identifier
highlight link gitmessengerHash Number
highlight link gitmessengerHistory Constant

noremap gm :GitMessenger<CR>
noremap gb :Gblame<CR>
noremap gs :vertical Gstatus<CR>
noremap gl :GV! -500<CR>
noremap gw :Gwrite<CR>
noremap gc :Gwrite<CR>:vertical Gcommit -v<CR>
noremap ga :Gwrite<CR>:vertical Gcommit -v --amend<CR>
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

" Easier split navigations
nnoremap <Down>  <C-W><C-J>
nnoremap <Up>    <C-W><C-K>
nnoremap <Right> <C-W><C-L>
nnoremap <Left>  <C-W><C-H>

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

" Open/close NERDTree
nmap <Leader>n :NERDTreeToggle<CR>

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

" These are to cancel the default behavior of d, D, c, C to put the text they
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

" Only put text in the default register when cut in visual mode
nnoremap x "_x
nnoremap X "_X

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

" Select the last pasted text with gp (similar to the standard gv which you can type to
" select the last visually-selected text)
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Any-fold {{{
let g:anyfold_fold_display = 0
let g:anyfold_fold_comments = 1
highlight Folded term=NONE cterm=NONE guibg=#333843

" Activate anyfold by default
augroup anyfold
  autocmd!
  autocmd Filetype * AnyFoldActivate
augroup end

" Disable anyfold for large files
" let g:LargeFile = 1000000    " file is large if size greater than 1MB
" augroup largefile
"   autocmd BufReadPre,BufRead * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
"   function LargeFile()
"     augroup anyfold
"       autocmd!    " remove AnyFoldActivate
"       autocmd Filetype * setlocal foldmethod=indent   " fall back to indent folding
"     augroup end
"   endfunction
" augroup end
" }}}

" Disable continuation of comments to the next line in Vim
augroup format-options
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup end

" Colorizer
lua require'colorizer'.setup()

" Lexima
let g:lexima_enable_basic_rules = 0

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

 nnoremap q :call CloseOnLast()<CR>

" Quickly close several buffers at once
nnoremap <silent> Q :Bdelete! menu<CR>

" Vim CtrlXA
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)

" Vim startify
nmap s :Startify<CR>

let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1

function! s:list_commits()
  let git = 'git'
  let commits = systemlist(git .' log --oneline | head -n10')
  let git = 'G'. git[1:]
  return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

let g:startify_lists = [
  \ { 'header': ['   MRU '. getcwd()], 'type': 'dir' },
  \ { 'header': ['   Bookmarks'],      'type': 'bookmarks'},
  \ { 'header': ['   Sessions'],       'type': 'sessions' },
  \ { 'header': ['   Commits'],        'type': function('s:list_commits') },
  \ ]

let g:startify_bookmarks = [
  \ {'c': '~/dotfiles/nvim/.config/nvim/init.vim'},
  \ {'b': '~/dotfiles/Brewfile'},
  \ ]

autocmd User Startified setlocal cursorline
autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)

nmap <Leader>e <plug>(scratch-insert-reuse)

" Custom file extensions / syntax highlighting
autocmd BufReadPost *.rules set filetype=yaml

" No magic search by default
map / /\V
map ? ?\V

" Vim wordmotion
let g:wordmotion_spaces = "_-./':,"
nmap cw ce
nmap cW cE
onoremap W :<C-U>normal! vWh<CR>

" coc-yank
noremap <Leader>p :CocList --normal yank<CR>

" vim-notes
let g:notes_directories = ['~/Documents/Notes']
let g:notes_suffix = '.md'

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

nnoremap ]w :NextTrailingWhitespace<CR>
nnoremap [w :PrevTrailingWhitespace<CR>

autocmd FileType fugitive DisableWhitespace
autocmd FileType git DisableWhitespace

" vim-gh-line
let g:gh_gitlab_domain = "gitlab.booking.com"
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 0
let g:gh_line_map = 'go'

" vim-indentguides
" space indents are visually identified by the "┆" character,
" while tabs are distinguished by "|"
set listchars=tab:\|\ ,

