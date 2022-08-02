" A minimal .vimrc file

" Format code on file save
function! FormatCode()
  noautocmd write

  let script_file =
        \ system('git rev-parse --show-toplevel')[:-2] .
        \ '/scripts/format-' . &filetype . '.sh'
  if v:shell_error != 0 || !filereadable(script_file)
    return
  endif

  let output = system(script_file . ' ' . expand('%:p'))
  if v:shell_error == 0
    let view = winsaveview()
    edit
    call winrestview(view)
  else
    echo output
  endif
endfunction

augroup format_code_on_save
  autocmd BufWriteCmd *.pp call FormatCode()
  autocmd BufWriteCmd *.yaml,*.eyaml,*.yml call FormatCode()
augroup end

map q :q!<CR>
map Q :q!<CR>
map gw :update<CR>

set nowrap
set cursorline
set number

" Insert spaces when Tab is pressed
set expandtab

set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

" Make it obvious where 80 characters is
set textwidth=79
set colorcolumn=+1

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
nnoremap y0  y0:call system("pbcopy", @0)<CR>
nnoremap y$  y$:call system("pbcopy", @0)<CR>
nnoremap ye  ye:call system("pbcopy", @0)<CR>
nnoremap yE  yE:call system("pbcopy", @0)<CR>
nnoremap yw  yw:call system("pbcopy", @0)<CR>
nnoremap yW  yW:call system("pbcopy", @0)<CR>
nnoremap yy  yy:call system("pbcopy", @0)<CR>
nnoremap yiw yiw:call system("pbcopy", @0)<CR>
nnoremap yib yib:call system("pbcopy", @0)<CR>
nnoremap yiq yiq:call system("pbcopy", @0)<CR>
nnoremap Y   Y:call system("pbcopy", @0)<CR>
vnoremap y   y:call system("pbcopy", @0)<CR>

" Automatically jump to end of text you pasted
vnoremap p :<C-u>set paste<CR>:let @a = system("pbpaste")<CR>"ap`]:set nopaste<CR>
nnoremap p :set paste<CR>:let @a = system("pbpaste")<CR>"ap`]:set nopaste<CR>
vnoremap P :<C-u>set paste<CR>:let @a = system("pbpaste")<CR>"aP`]:set nopaste<CR>
nnoremap P :set paste<CR>:let @a = system("pbpaste")<CR>"aP`]:set nopaste<CR>

" Don't change the clipboard if paste over a visually selected text
xnoremap p "_d:set paste<CR>:let @a = system("pbpaste")<CR>"aP`]:set nopaste<CR>

" Fix vim x/X in VISUAL mode doesn't copy text to macOS' clipboard
vnoremap x ygvx
vnoremap X ygvX

"===========================================================================
"
" Vim log highlighting
"
" https://github.com/MTDL9/vim-log-highlighting/blob/master/syntax/log.vim
"
"===========================================================================

" Vim syntax file
" Language:         Generic log file
" Maintainer:       MTDL9 <https://github.com/MTDL9>
" Latest Revision:  2020-08-23

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpoptions
set cpoptions&vim


" Operators
"---------------------------------------------------------------------------
syn match logOperator display '[;,\?\:\.\<=\>\~\/\@\!$\%&\+\-\|\^(){}\*#]'
syn match logBrackets display '[\[\]]'
syn match logEmptyLines display '-\{3,}'
syn match logEmptyLines display '\*\{3,}'
syn match logEmptyLines display '=\{3,}'
syn match logEmptyLines display '- - '


" Constants
"---------------------------------------------------------------------------
syn match logNumber       '\<-\?\d\+\>'
syn match logHexNumber    '\<0[xX]\x\+\>'
syn match logHexNumber    '\<\d\x\+\>'
syn match logBinaryNumber '\<0[bB][01]\+\>'
syn match logFloatNumber  '\<\d.\d\+[eE]\?\>'

syn keyword logBoolean    TRUE FALSE True False true false
syn keyword logNull       NULL Null null

syn region logString      start=/"/ end=/"/ end=/$/ skip=/\\./
" Quoted strings, but no match on quotes like "don't", "plurals' elements"
syn region logString      start=/'\(s \|t \| \w\)\@!/ end=/'/ end=/$/ end=/s / skip=/\\./


" Dates and Times
"---------------------------------------------------------------------------
" Matches 2018-03-12T or 12/03/2018 or 12/Mar/2018
syn match logDate '\d\{2,4}[-\/]\(\d\{2}\|Jan\|Feb\|Mar\|Apr\|May\|Jun\|Jul\|Aug\|Sep\|Oct\|Nov\|Dec\)[-\/]\d\{2,4}T\?'
" Matches 8 digit numbers at start of line starting with 20
syn match logDate '^20\d\{6}'
" Matches Fri Jan 09 or Feb 11 or Apr  3 or Sun 3
syn keyword logDate Mon Tue Wed Thu Fri Sat Sun Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec nextgroup=logDateDay
syn match logDateDay '\s\{1,2}\d\{1,2}' contained

" Matches 12:09:38 or 00:03:38.129Z or 01:32:12.102938 +0700
syn match logTime '\d\{2}:\d\{2}:\d\{2}\(\.\d\{2,6}\)\?\(\s\?[-+]\d\{2,4}\|Z\)\?\>' nextgroup=logTimeZone,logSysColumns skipwhite

" Follows logTime, matches UTC or PDT 2019 or 2019 EDT
syn match logTimeZone '[A-Z]\{2,5}\>\( \d\{4}\)\?' contained
syn match logTimeZone '\d\{4} [A-Z]\{2,5}\>' contained


" Entities
"---------------------------------------------------------------------------
syn match logUrl        'http[s]\?:\/\/[^\n|,; '"]\+'
syn match logDomain     /\v(^|\s)(\w|-)+(\.(\w|-)+)+\s/
syn match logUUID       '\w\{8}-\w\{4}-\w\{4}-\w\{4}-\w\{12}'
syn match logMD5        '\<[a-z0-9]\{32}\>'
syn match logIPV4       '\<\d\{1,3}\(\.\d\{1,3}\)\{3}\>'
syn match logIPV6       '\<\x\{1,4}\(:\x\{1,4}\)\{7}\>'
syn match logMacAddress '\<\x\{2}\(:\x\{2}\)\{5}'
syn match logFilePath   '\<\w:\\[^\n|,; ()'"\]{}]\+'
syn match logFilePath   '[^a-zA-Z0-9"']\@<=\/\w[^\n|,; ()'"\]{}]\+'


" Syslog Columns
"---------------------------------------------------------------------------
" Syslog hostname, program and process number columns
syn match logSysColumns '\w\(\w\|\.\|-\)\+ \(\w\|\.\|-\)\+\(\[\d\+\]\)\?:' contains=logOperator,logSysProcess contained
syn match logSysProcess '\(\w\|\.\|-\)\+\(\[\d\+\]\)\?:' contains=logOperator,logNumber,logBrackets contained


" XML Tags
"---------------------------------------------------------------------------
" Simplified matches, not accurate with the spec to avoid false positives
syn match logXmlHeader       /<?\(\w\|-\)\+\(\s\+\w\+\(="[^"]*"\|='[^']*'\)\?\)*?>/ contains=logString,logXmlAttribute,logXmlNamespace
syn match logXmlDoctype      /<!DOCTYPE[^>]*>/ contains=logString,logXmlAttribute,logXmlNamespace
syn match logXmlTag          /<\/\?\(\(\w\|-\)\+:\)\?\(\w\|-\)\+\(\(\n\|\s\)\+\(\(\w\|-\)\+:\)\?\(\w\|-\)\+\(="[^"]*"\|='[^']*'\)\?\)*\s*\/\?>/ contains=logString,logXmlAttribute,logXmlNamespace
syn match logXmlAttribute    contained "\w\+=" contains=logOperator
syn match logXmlAttribute    contained "\(\n\|\s\)\(\(\w\|-\)\+:\)\?\(\w\|-\)\+\(=\)\?" contains=logXmlNamespace,logOperator
syn match logXmlNamespace    contained "\(\w\|-\)\+:" contains=logOperator
syn region logXmlComment     start=/<!--/ end=/-->/
syn match logXmlCData        /<!\[CDATA\[.*\]\]>/
syn match logXmlEntity       /&#\?\w\+;/


" Levels
"---------------------------------------------------------------------------
syn keyword logLevelEmergency EMERGENCY EMERG
syn keyword logLevelAlert ALERT
syn keyword logLevelCritical CRITICAL CRIT FATAL
syn keyword logLevelError ERROR ERR FAILURE SEVERE
syn keyword logLevelWarning WARNING WARN
syn keyword logLevelNotice NOTICE
syn keyword logLevelInfo INFO
syn keyword logLevelDebug DEBUG FINE
syn keyword logLevelTrace TRACE FINER FINEST


" Highlight links
"---------------------------------------------------------------------------
hi def link logNumber Number
hi def link logHexNumber Number
hi def link logBinaryNumber Number
hi def link logFloatNumber Float
hi def link logBoolean Boolean
hi def link logNull Constant
hi def link logString String

hi def link logDate Identifier
hi def link logDateDay Identifier
hi def link logTime Function
hi def link logTimeZone Identifier

hi def link logUrl Underlined
hi def link logDomain Label
hi def link logUUID Label
hi def link logMD5 Label
hi def link logIPV4 Label
hi def link logIPV6 ErrorMsg
hi def link logMacAddress Label
hi def link logFilePath Conditional

hi def link logSysColumns Conditional
hi def link logSysProcess Include

hi def link logXmlHeader Function
hi def link logXmlDoctype Function
hi def link logXmlTag Identifier
hi def link logXmlAttribute Type
hi def link logXmlNamespace Include
hi def link logXmlComment Comment
hi def link logXmlCData String
hi def link logXmlEntity Special

hi def link logOperator Operator
hi def link logBrackets Comment
hi def link logEmptyLines Comment

hi def link logLevelEmergency ErrorMsg
hi def link logLevelAlert ErrorMsg
hi def link logLevelCritical ErrorMsg
hi def link logLevelError ErrorMsg
hi def link logLevelWarning WarningMsg
hi def link logLevelNotice Character
hi def link logLevelInfo Repeat
hi def link logLevelDebug Debug
hi def link logLevelTrace Comment



let b:current_syntax = 'log'

let &cpoptions = s:cpo_save
unlet s:cpo_save




"===========================================================================
"
" Aodark color scheme
"
" https://github.com/anhpt379/dotfiles/blob/master/nvim/.config/nvim/colors/aodark.vim
"
"===========================================================================

set background=dark
highlight clear
syntax reset

let g:colors_name='aodark'
let colors_name='aodark'

let s:black       = { 'gui': '#101011', 'cterm': '0'  }
let s:red         = { 'gui': '#e22f62', 'cterm': '9'  }
let s:green       = { 'gui': '#5fae4d', 'cterm': '10' }
let s:yellow      = { 'gui': '#deb246', 'cterm': '11' }
let s:blue        = { 'gui': '#28c9ff', 'cterm': '12' }
let s:purple      = { 'gui': '#b954e1', 'cterm': '13' }
let s:cyan        = { 'gui': '#3cc8b4', 'cterm': '14' }
let s:white       = { 'gui': '#f1f1f1', 'cterm': '15' }

let s:fg          = s:white
let s:bg          = s:black

let s:comment_fg  = { 'gui': '#696969', 'cterm': '241'  }
let s:gutter_bg   = { 'gui': '#262626', 'cterm': 'NONE' }
let s:gutter_fg   = { 'gui': '#444444', 'cterm': '238'  }

let s:cursor_line = { 'gui': '#262626', 'cterm': '235'  }
let s:color_col   = { 'gui': '#1f1f22', 'cterm': '234'  }

let s:selection   = { 'gui': '#28c9ff', 'cterm': '75'  }
let s:vertsplit   = { 'gui': '#262626', 'cterm': '235'  }
let s:pmenuselect = { 'gui': '#0060c0', 'cterm': '26'  }

let s:non_text    = { 'gui': '#555555', 'cterm': '59'   }
let s:search      = { 'gui': '#FFCC66', 'cterm': '11'   }
let s:incsearch   = { 'gui': '#FAB955', 'cterm': '214'  }
let s:punctuation = { 'gui': '#C9C9C9', 'cterm': '251'  }

function! s:h(group, fg, bg, attr)
  if type(a:fg) == type({})
    exec 'hi ' . a:group . ' guifg=' . a:fg.gui . ' ctermfg=' . a:fg.cterm
  else
    exec 'hi ' . a:group . ' guifg=NONE cterm=NONE'
  endif
  if type(a:bg) == type({})
    exec 'hi ' . a:group . ' guibg=' . a:bg.gui . ' ctermbg=' . a:bg.cterm
  else
    exec 'hi ' . a:group . ' guibg=NONE ctermbg=NONE'
  endif
  if a:attr !=# ''
    exec 'hi ' . a:group . ' gui=' . a:attr . ' cterm=' . a:attr
  else
    exec 'hi ' . a:group . ' gui=NONE cterm=NONE'
  endif
endfun

" User interface colors
call s:h('Normal', s:fg, s:bg, '')
call s:h('NonText', s:non_text, '', '')

call s:h('Cursor', s:bg, s:blue, '')
call s:h('CursorColumn', '', s:cursor_line, '')
call s:h('CursorLine', '', s:cursor_line, '')

call s:h('LineNr', s:gutter_fg, '', '')
call s:h('CursorLineNr', s:fg, s:cursor_line, '')

call s:h('DiffAdd', s:green, '', '')
call s:h('DiffChange', s:yellow, '', '')
call s:h('DiffDelete', s:red, '', '')
call s:h('DiffText', s:blue, '', '')

call s:h('IncSearch', s:bg, s:incsearch, '')
call s:h('Search', s:bg, s:search, '')

call s:h('ErrorMsg', s:red, '', '')
call s:h('ModeMsg', s:fg, '', '')
call s:h('MoreMsg', s:fg, '', '')
call s:h('WarningMsg', s:yellow, '', '')
call s:h('Question', s:purple, '', '')

call s:h('Pmenu', s:fg, s:gutter_bg   , '')
call s:h('PmenuSel', s:fg, s:blue, '')
call s:h('PmenuSbar', '', s:selection, '')
call s:h('PmenuThumb', '', s:fg, '')

call s:h('SpellBad', s:red, '', '')
call s:h('SpellCap', s:yellow, '', '')
call s:h('SpellLocal', s:yellow, '', '')
call s:h('SpellRare', s:yellow, '', '')

call s:h('StatusLine', s:blue, s:cursor_line, '')
call s:h('StatusLineNC', s:comment_fg, s:cursor_line, '')
call s:h('TabLine', s:comment_fg, s:cursor_line, '')
call s:h('TabLineFill', s:comment_fg, s:cursor_line, '')
call s:h('TabLineSel', s:fg, s:bg, '')

call s:h('Visual', s:bg, s:selection, '')
call s:h('VisualNOS', '', s:selection, '')

call s:h('ColorColumn', '', s:color_col, '')
call s:h('Conceal', s:fg, '', '')
call s:h('Directory', s:white, '', '')
call s:h('VertSplit', s:vertsplit, s:vertsplit, '')
call s:h('Folded', s:fg, '', '')
call s:h('FoldColumn', s:fg, '', '')
call s:h('SignColumn', s:fg, '', '')

call s:h('MatchParen', s:blue, '', 'underline')
call s:h('SpecialKey', s:fg, '', '')
call s:h('Title', s:yellow, '', '')
call s:h('WildMenu', s:fg, '', '')

" Syntax colors
call s:h('Comment', s:comment_fg, '', '')
call s:h('Constant', s:purple, '', '')
call s:h('String', s:yellow, '', '')
call s:h('Character', s:yellow, '', '')
call s:h('Number', s:green, '', '')
call s:h('Boolean', s:green, '', '')
call s:h('Float', s:green, '', '')

call s:h('Identifier', s:blue, '', '')
call s:h('Function', s:red, '', '')
call s:h('Statement', s:cyan, '', '')

call s:h('Conditional', s:cyan, '', '')
call s:h('Repeat', s:cyan, '', '')
call s:h('Label', s:cyan, '', '')
call s:h('Operator', s:punctuation, '', '')
call s:h('Keyword', s:cyan, '', '')
call s:h('Exception', s:cyan, '', '')

call s:h('PreProc', s:yellow, '', '')
call s:h('Include', s:cyan, '', '')
call s:h('Define', s:cyan, '', '')
call s:h('Macro', s:purple, '', '')
call s:h('PreCondit', s:yellow, '', '')

call s:h('Type', s:yellow, '', '')
call s:h('StorageClass', s:yellow, '', '')
call s:h('Structure', s:yellow, '', '')
call s:h('Typedef', s:yellow, '', '')

call s:h('Special', s:red, '', '')
call s:h('SpecialChar', s:fg, '', '')
call s:h('Tag', s:fg, '', '')
call s:h('Delimiter', s:punctuation, '', '')
call s:h('SpecialComment', s:fg, '', '')
call s:h('Debug', s:fg, '', '')
call s:h('Underlined', s:fg, '', '')
call s:h('Ignore', s:fg, '', '')
call s:h('Error', s:red, s:gutter_bg, '')
call s:h('Todo', s:purple, '', '')

" GitSigns
call s:h('GitSignsAdd', s:green, s:gutter_bg, '')
call s:h('GitSignsDelete', s:red, s:gutter_bg, '')
call s:h('GitSignsChange', s:yellow, s:gutter_bg, '')
call s:h('GitSignsCurrentLineBlame', s:comment_fg, s:gutter_bg, '')

" Fugitive
call s:h('diffAdded', s:green, '', '')
call s:h('diffRemoved', s:red, '', '')

" Git
call s:h('gitcommitComment', s:comment_fg, '', '')
call s:h('gitcommitUnmerged', s:red, '', '')
call s:h('gitcommitOnBranch', s:fg, '', '')
call s:h('gitcommitBranch', s:purple, '', '')
call s:h('gitcommitDiscardedType', s:red, '', '')
call s:h('gitcommitSelectedType', s:green, '', '')
call s:h('gitcommitHeader', s:fg, '', '')
call s:h('gitcommitUntrackedFile', s:cyan, '', '')
call s:h('gitcommitDiscardedFile', s:red, '', '')
call s:h('gitcommitSelectedFile', s:green, '', '')
call s:h('gitcommitUnmergedFile', s:yellow, '', '')
call s:h('gitcommitFile', s:fg, '', '')

highlight link gitcommitNoBranch gitcommitBranch
highlight link gitcommitUntracked gitcommitComment
highlight link gitcommitDiscarded gitcommitComment
highlight link gitcommitSelected gitcommitComment
highlight link gitcommitDiscardedArrow gitcommitDiscardedFile
highlight link gitcommitSelectedArrow gitcommitSelectedFile
highlight link gitcommitUnmergedArrow gitcommitUnmergedFile

highlight gitmessengerPopupNormal guibg=#101011 ctermbg=0
highlight link gitmessengerHeader Identifier
highlight link gitmessengerHash Number
highlight link gitmessengerHistory Constant

" Folded highlighting
highlight Folded term=bold gui=bold cterm=NONE guifg=#696969

" Highlightedyank
highlight HighlightedyankRegion term=bold ctermbg=11 ctermfg=15 guibg=#e5c07b guifg=#ffffff

" Conflict maker
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerSeparator guifg=#e5c07b
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e

" Clever-f
highlight CleverFDefaultLabel guifg=#ffb300 gui=bold,underline ctermfg=11 ctermbg=235 cterm=bold,underline
highlight CleverFDirect       guifg=#ffb300 gui=bold           ctermfg=11 ctermbg=235 cterm=bold
