" Quickly reload nvim config & update plugins
nnoremap <Leader>u :source ~/.config/nvim/init.vim<CR>
  \ :TSUpdate<CR>
  \ :PlugClean<CR>
  \ :silent! PlugInstall<CR>
  \ :PlugUpdate --sync<CR>
  \ :PlugUpgrade<CR>
  \ :PlugDiff<CR>

" Navigate properly when lines are wrapped
noremap j gj
noremap k gk

" Use U as redo
noremap U <C-R>

" <C-c> (close) to save & close the current buffer
imap <C-c> <C-O>:x<CR>
nmap <C-c> :x<CR>

" Don't change the clipboard if paste over a visually selected text
xnoremap <expr> p 'pgv"' . v:register . 'y'

" Duplicate a line and comment out the first line
nmap yc yy<Leader>cp

" Keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv

" Use <Tab> and <S-Tab> to indent/outdent the code blocks
vmap <Tab> >gv
vmap <S-Tab> <gv

" Y yanks until EOL, more like D and C
nnoremap Y y$

" Jump to top/bottom of the file with <Home>/<End>
nmap <Home> gg
nmap <End> G
imap <Home> <ESC>I
imap <End> <ESC>A

" Prevent cursor from moving back when exiting INSERT mode
inoremap <Esc> <Esc>`^
inoremap <C-c> <Esc>`^
inoremap <C-[> <Esc>`^

" Split line (sister to [J]oin lines)
nnoremap S i<CR><ESC>:StripWhitespace<CR>

" Use `==` for formatting the current line (or visual selection)
vnoremap == gw
nnoremap == Vgw

" These are to cancel the default behavior of d, D, c, C, s
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

" Faster substitute with repeat
map <C-u> <Plug>(RepeatRedo)

" Select the last pasted text with vp
nnoremap <expr> vp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Lexima
let g:lexima_map_escape = ''
let g:lexima_enable_basic_rules = 0

" Sandwich
runtime macros/sandwich/keymap/surround.vim
xmap a <Plug>(operator-sandwich-add)
nmap yq ysiw'
nmap cq <Plug>(sandwich-replace-auto)
nmap dq <Plug>(sandwich-delete-auto)

" Remap recording macro key to F20 BEFORE remapping q, so it captures the original q behavior (macro recording)
nnoremap <F20> q

" Bclose
let g:bclose_no_plugin_maps = v:true
function! Goodbye()
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    quit!
  else
    bd!
  endif
endfunction

nnoremap <silent> q :<C-u>silent! call Goodbye()<CR>

" Close all buffers without saving
nnoremap <silent> Q :qa!<CR>

" Vim-better-whitespace
let g:strip_whitespace_on_save = 0
let g:strip_whitelines_at_eof = 1
let g:better_whitespace_operator = ''
let g:current_line_whitespace_disabled_soft = 1

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

" Command-line mode shortcuts
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>
cmap <C-h> <Home>
cmap <C-l> <End>

" Fix Control/Option+Backspace/Delete in command line
cnoremap        <M-BS> <C-w>
cnoremap <expr> <C-Del> &cedit. 'dW' .'<C-c><Space><BS>'
cnoremap <expr> <M-Del> &cedit. 'dw' .'<C-c><Space><BS>'

" Allow Control/Option+Backspace/Delete in insert mode
inoremap <C-h>   <Left><C-o>dvB
inoremap <M-BS>  <Left><C-o>dvb
inoremap <C-Del> <C-o>dW
inoremap <M-d>   <C-o>dw

" Suda & vim-eunuch
let g:suda_smart_edit = 1
let g:suda#try_without_password = !has('nvim')
command! SudoWrite w suda://%

" Vim-after-object
augroup vim-after-object
  autocmd!
  autocmd VimEnter * silent! call after_object#enable([']', '['], '=', ':', '#', ' ', '|', '*')
augroup end

" IndentWise
nmap <silent> ]i <Plug>(IndentWiseNextGreaterIndent)
nmap <silent> [i <Plug>(IndentWisePreviousLesserIndent)

" Google search in visual mode
function! GoogleSearchImFeelingLucky()
  let searchterm = getreg('g')
  silent! exec 'silent! !open "http://www.google.com/search?sourceid=navclient&gfns=1&q=' . searchterm . '" &'
endfunction

vnoremap gx "gy<Esc>:call GoogleSearchImFeelingLucky()<CR>

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)

" open-browser.vim
let g:openbrowser_browser_commands = [{'name': 'open', 'args': ['{browser}', '{uri}']}]
nmap gx <Plug>(openbrowser-smart-search)

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

" Enhanced jumps - <C-o> <C-i> within same file only
let g:EnhancedJumps_CaptureJumpMessages = 0
let g:EnhancedJumps_no_mappings = 1
map <C-o> <Plug>EnhancedJumpsLocalOlder
map <C-i> <Plug>EnhancedJumpsLocalNewer

" Resize splits with Shift+Arrow keys
nnoremap <silent> <S-Left>  :CmdResizeLeft<CR>
nnoremap <silent> <S-Down>  :CmdResizeDown<CR>
nnoremap <silent> <S-Up>    :CmdResizeUp<CR>
nnoremap <silent> <S-Right> :CmdResizeRight<CR>

" Toggle between `^` and `0` by pressing `0` repeatedly
function! ToggleHomeZero()
  let pos = getpos('.')
  execute 'normal! ^'
  if pos == getpos('.')
    execute 'normal! 0'
  endif
endfunction

nnoremap 0 :call ToggleHomeZero()<CR>

" Line text objects
xnoremap il g_o^
onoremap il :normal vil<CR>
xnoremap al $o^
onoremap al :normal val<CR>

" Move view left/right with H/L
map H zH
map L zL

" Easier change list jumps
nnoremap <Leader>o g;
nnoremap <Leader>i g,

" Toggle line numbers
map [n :<C-u>set nonumber<CR>
map ]n :<C-u>set number<CR>

" Toggle wrap
map [w :<C-u>set wrap!<CR>
map ]w :<C-u>set wrap!<CR>

" Copy path to clipboard
command! CPP :call system('pbcopy', fnamemodify(expand("%"), ":~:."))

" Format shell commands
command! -range FormatShellCmd <line1>!~/.config/nvim/bin/format_shell_cmd.py

