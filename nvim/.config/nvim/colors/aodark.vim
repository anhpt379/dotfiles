set background=dark
highlight clear
syntax reset

let g:colors_name='aodark'
let colors_name='aodark'

let s:black       = { 'gui': '#17171d', 'cterm': '0'  }
let s:red         = { 'gui': '#DE456B', 'cterm': '9'  }
let s:green       = { 'gui': '#8DC26C', 'cterm': '10' }
let s:yellow      = { 'gui': '#E2B962', 'cterm': '11' }
let s:blue        = { 'gui': '#3BB0E0', 'cterm': '12' }
let s:purple      = { 'gui': '#C068DF', 'cterm': '13' }
let s:cyan        = { 'gui': '#55CABE', 'cterm': '14' }
let s:white       = { 'gui': '#F1F1F1', 'cterm': '15' }

let s:fg          = s:white
let s:bg          = s:black

let s:comment_fg  = { 'gui': '#696969', 'cterm': '241'  }
let s:gutter_bg   = { 'gui': '#282829', 'cterm': 'NONE' }
let s:gutter_fg   = { 'gui': '#444444', 'cterm': '238'  }

let s:cursor_line = { 'gui': '#252526', 'cterm': '235'  }
let s:color_col   = { 'gui': '#1f1f22', 'cterm': '234'  }

let s:selection   = { 'gui': '#444444', 'cterm': '238'  }
let s:vertsplit   = { 'gui': '#262626', 'cterm': '235'  }

let s:non_text    = { 'gui': '#555555', 'cterm': '59'   }

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
  if a:attr != ''
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
call s:h('CursorLineNr', s:fg, '', '')

call s:h('DiffAdd', s:green, '', '')
call s:h('DiffChange', s:yellow, '', '')
call s:h('DiffDelete', s:red, '', '')
call s:h('DiffText', s:blue, '', '')

call s:h('IncSearch', s:bg, s:yellow, '')
call s:h('Search', s:bg, s:yellow, '')

call s:h('ErrorMsg', s:fg, '', '')
call s:h('ModeMsg', s:fg, '', '')
call s:h('MoreMsg', s:fg, '', '')
call s:h('WarningMsg', s:red, '', '')
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

call s:h('Visual', '', s:selection, '')
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
call s:h('Operator', s:fg, '', '')
call s:h('Keyword', s:red, '', '')
call s:h('Exception', s:cyan, '', '')

call s:h('PreProc', s:yellow, '', '')
call s:h('Include', s:red, '', '')
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
call s:h('Delimiter', s:fg, '', '')
call s:h('SpecialComment', s:fg, '', '')
call s:h('Debug', s:fg, '', '')
call s:h('Underlined', s:fg, '', '')
call s:h('Ignore', s:fg, '', '')
call s:h('Error', s:red, s:gutter_bg, '')
call s:h('Todo', s:purple, '', '')

" GitGutter
call s:h('GitGutterAdd', s:green, s:gutter_bg, '')
call s:h('GitGutterDelete', s:red, s:gutter_bg, '')
call s:h('GitGutterChange', s:yellow, s:gutter_bg, '')
call s:h('GitGutterChangeDelete', s:red, s:gutter_bg, '')

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

highlight gitmessengerPopupNormal guibg=#333333
highlight link gitmessengerHeader Identifier
highlight link gitmessengerHash Number
highlight link gitmessengerHistory Constant

" Fix colors in neovim terminal buffers
if has('nvim')
  let g:terminal_color_0 = s:comment_fg.gui
  let g:terminal_color_1 = s:red.gui
  let g:terminal_color_2 = s:green.gui
  let g:terminal_color_3 = s:yellow.gui
  let g:terminal_color_4 = s:blue.gui
  let g:terminal_color_5 = s:purple.gui
  let g:terminal_color_6 = s:cyan.gui
  let g:terminal_color_7 = s:white.gui
  let g:terminal_color_8 = s:black.gui
  let g:terminal_color_9 = s:red.gui
  let g:terminal_color_10 = s:green.gui
  let g:terminal_color_11 = s:yellow.gui
  let g:terminal_color_12 = s:blue.gui
  let g:terminal_color_13 = s:purple.gui
  let g:terminal_color_14 = s:cyan.gui
  let g:terminal_color_15 = s:white.gui
  let g:terminal_color_background = s:bg.gui
  let g:terminal_color_foreground = s:fg.gui
endif

" Anyfold
highlight Folded term=NONE cterm=NONE guibg=#333843

" Highlightedyank
highlight HighlightedyankRegion term=bold ctermbg=11 ctermfg=15 guibg=#e5c07b guifg=#ffffff

" Conflict maker
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerSeparator guifg=#e5c07b
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e

" Coc.nvim
highlight CocFloating guibg=#4D5565
highlight CocErrorHighlight guifg=#e06c75
highlight CocWarningHighlight guifg=#e5c07b

