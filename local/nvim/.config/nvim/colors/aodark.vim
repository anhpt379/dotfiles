set background=dark
highlight clear
syntax reset

let g:colors_name='aodark'
let colors_name='aodark'

" let s:black       = { 'gui': '#161616', 'cterm': '0'  }
" let s:red         = { 'gui': '#e22f62', 'cterm': '9'  }
" let s:green       = { 'gui': '#5fae4d', 'cterm': '10' }
" let s:yellow      = { 'gui': '#deb246', 'cterm': '11' }
" let s:blue        = { 'gui': '#28c9ff', 'cterm': '12' }
" let s:purple      = { 'gui': '#b954e1', 'cterm': '13' }
" let s:cyan        = { 'gui': '#3cc8b4', 'cterm': '14' }
" let s:white       = { 'gui': '#eeeeee', 'cterm': '15' }
let s:black       = { 'gui': '#161616', 'cterm': '0'  }
let s:red         = { 'gui': '#bbbbbb', 'cterm': '9'  }
let s:orange      = { 'gui': '#e07653', 'cterm': '9'  }
let s:green       = { 'gui': '#dddddd', 'cterm': '10' }
let s:yellow      = { 'gui': '#bbbbbb', 'cterm': '11' }
let s:blue        = { 'gui': '#dddddd', 'cterm': '12' }
let s:purple      = { 'gui': '#dddddd', 'cterm': '13' }
let s:cyan        = { 'gui': '#3cc8b4', 'cterm': '14' }
let s:white       = { 'gui': '#eeeeee', 'cterm': '15' }

let s:fg          = s:white
let s:bg          = s:black

let s:comment_fg  = { 'gui': '#696969', 'cterm': '241'  }
let s:gutter_bg   = { 'gui': '#262626', 'cterm': 'NONE' }
let s:gutter_fg   = { 'gui': '#444444', 'cterm': '238'  }

let s:cursor_line = { 'gui': '#262626', 'cterm': '235'  }
let s:color_col   = { 'gui': '#1f1f22', 'cterm': '234'  }

let s:selection   = { 'gui': '#eeeeee', 'cterm': '15'   }
let s:vertsplit   = { 'gui': '#262626', 'cterm': '235'  }
let s:pmenuselect = { 'gui': '#0060c0', 'cterm': '26'   }

let s:non_text    = { 'gui': '#555555', 'cterm': '59'   }
let s:search      = { 'gui': '#3cc8b4', 'cterm': '14'   }
let s:incsearch   = { 'gui': '#ffcc66', 'cterm': '12'   }
let s:punctuation = { 'gui': '#c9c9c9', 'cterm': '251'  }

let s:textyankpost = { 'gui': '#ffcc66', 'cterm': '11'  }

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
call s:h('Search', s:black, s:search, '')

call s:h('ErrorMsg', s:red, '', '')
call s:h('ModeMsg', s:fg, '', '')
call s:h('MoreMsg', s:fg, '', '')
call s:h('WarningMsg', s:yellow, '', '')
call s:h('Question', s:purple, '', '')

call s:h('Pmenu', s:fg, s:gutter_bg, '')
call s:h('PmenuSel', '', s:pmenuselect, '')
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

call s:h('TextYankPost', s:bg, s:textyankpost, '')

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
call s:h('Function', s:orange, '', '')
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
call s:h('diffAdded', {'gui': '#5fae4d', 'cterm': '10'}, '', '')
call s:h('diffRemoved', {'gui': '#e22f62', 'cterm': '9'}, '', '')

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

highlight gitmessengerPopupNormal guibg=#000000 ctermbg=0
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

" Coc.nvim
highlight CocFloating guibg=#282829
highlight CocErrorHighlight guifg=#dd3c69
highlight CocWarningHighlight guifg=#d6b152
highlight CocHintHighlight guifg=#ffffff gui=underline
highlight CocHintSign guifg=#55CABE
highlight link CocErrorSign CocErrorHighlight
highlight link CocWarningSign CocWarningHighlight

" Clever-f
highlight CleverFDefaultLabel guifg=#ffb300 gui=bold,underline ctermfg=11 ctermbg=235 cterm=bold,underline
highlight CleverFDirect       guifg=#ffb300 gui=bold           ctermfg=11 ctermbg=235 cterm=bold

" CtrlSF
highlight link ctrlsfMatch Search
highlight link ctrlsfLnumMatch LineNr

" vim-sneak
highlight Sneak guifg=black guibg=white ctermfg=black ctermbg=white
highlight SneakScope guifg=white guibg=#28c9ff ctermfg=white ctermbg=blue

" vim-log-highlighting
highlight link logNumber Directory
highlight link logHexNumber Directory
highlight link logBinaryNumber Directory
highlight link logFloatNumber Directory
highlight link logBoolean Boolean
highlight link logNull Constant
highlight link logString String

highlight link logDate Directory
highlight link logDateDay Directory
highlight link logTime Directory
highlight link logTimeZone Directory

highlight link logUrl Underlined
highlight link logDomain Label
highlight link logUUID Label
highlight link logMD5 Label
highlight link logIPV4 Label
highlight link logIPV6 ErrorMsg
highlight link logMacAddress Label
highlight link logFilePath Conditional

highlight link logSysColumns Conditional
highlight link logSysProcess Include

highlight link logXmlHeader Function
highlight link logXmlDoctype Function
highlight link logXmlTag Identifier
highlight link logXmlAttribute Type
highlight link logXmlNamespace Include
highlight link logXmlComment Comment
highlight link logXmlCData String
highlight link logXmlEntity Special

highlight link logOperator Operator
highlight link logBrackets Comment
highlight link logEmptyLines Comment

highlight link logLevelEmergency ErrorMsg
highlight link logLevelAlert ErrorMsg
highlight link logLevelCritical ErrorMsg
highlight link logLevelError ErrorMsg
highlight link logLevelWarning WarningMsg
highlight link logLevelNotice Character
highlight link logLevelInfo DiffAdd
highlight link logLevelDebug Comment
highlight link logLevelTrace Comment
