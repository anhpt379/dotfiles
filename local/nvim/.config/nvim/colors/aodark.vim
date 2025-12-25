" aodark.vim - A dark colorscheme for Neovim (requires termguicolors)

if !has('termguicolors')
  echoerr 'aodark requires termguicolors support'
  finish
endif

set background=dark
highlight clear
if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'aodark'
set termguicolors

" Color Palette {{{
let s:p = {}

" Base colors
let s:p.black       = '#161616'
let s:p.red         = '#bbbbbb'
let s:p.orange      = '#e07653'
let s:p.green       = '#dddddd'
let s:p.yellow      = '#bbbbbb'
let s:p.blue        = '#dddddd'
let s:p.purple      = '#dddddd'
let s:p.cyan        = '#3cc8b4'
let s:p.white       = '#eeeeee'

" UI colors
let s:p.fg            = s:p.white
let s:p.bg            = s:p.black
let s:p.comment_fg    = '#696969'
let s:p.gutter_bg     = '#262626'
let s:p.gutter_fg     = '#444444'
let s:p.cursor_line   = '#262626'
let s:p.color_col     = '#1f1f22'
let s:p.selection     = '#eeeeee'
let s:p.vertsplit     = '#262626'
let s:p.pmenuselect   = '#0060c0'
let s:p.non_text      = '#555555'
let s:p.search        = '#3cc8b4'
let s:p.incsearch     = '#ffcc66'
let s:p.punctuation   = '#c9c9c9'
let s:p.textyankpost  = '#ffcc66'
" }}}

" Helper Functions {{{
function! s:hl(group, fg, ...) abort
  let l:bg = get(a:, 1, '')
  let l:attr = get(a:, 2, 'NONE')

  execute printf('highlight %s guifg=%s guibg=%s gui=%s',
    \ a:group,
    \ empty(a:fg) ? 'NONE' : a:fg,
    \ empty(l:bg) ? 'NONE' : l:bg,
    \ l:attr)
endfunction

function! s:link(from, to) abort
  execute 'highlight! link' a:from a:to
endfunction
" }}}

" UI Highlights {{{
call s:hl('Normal',       s:p.fg,        s:p.bg)
call s:hl('NonText',      s:p.non_text,  '')
call s:hl('Cursor',       s:p.bg,        s:p.blue)
call s:hl('CursorColumn', '',            s:p.cursor_line)
call s:hl('CursorLine',   '',            s:p.cursor_line)
call s:hl('LineNr',       s:p.gutter_fg, '')
call s:hl('CursorLineNr', s:p.fg,        s:p.cursor_line)
call s:hl('ColorColumn',  '',            s:p.color_col)
call s:hl('Conceal',      s:p.fg,        '')
call s:hl('Directory',    s:p.white,     '')
call s:hl('VertSplit',    s:p.vertsplit, s:p.vertsplit)
call s:hl('WinSeparator', s:p.vertsplit, '')
call s:hl('Folded',       s:p.comment_fg, '', 'bold')
call s:hl('FoldColumn',   s:p.fg,        '')
call s:hl('SignColumn',   s:p.fg,        '')
call s:hl('MatchParen',   s:p.blue,      '', 'underline')
call s:hl('SpecialKey',   s:p.fg,        '')
call s:hl('Title',        s:p.yellow,    '')
call s:hl('WildMenu',     s:p.fg,        '')
" }}}

" Diff {{{
call s:hl('DiffAdd',    s:p.green,  '')
call s:hl('DiffChange', s:p.yellow, '')
call s:hl('DiffDelete', s:p.red,    '')
call s:hl('DiffText',   s:p.blue,   '')
" }}}

" Search {{{
call s:hl('IncSearch', s:p.bg,    s:p.incsearch)
call s:hl('Search',    s:p.black, s:p.search)
" }}}

" Messages {{{
call s:hl('ErrorMsg',   s:p.red,    '')
call s:hl('ModeMsg',    s:p.fg,     '')
call s:hl('MoreMsg',    s:p.fg,     '')
call s:hl('WarningMsg', s:p.yellow, '')
call s:hl('Question',   s:p.purple, '')
" }}}

" Popup Menu {{{
call s:hl('Pmenu',      s:p.fg, s:p.gutter_bg)
call s:hl('PmenuSel',   '',     s:p.pmenuselect)
call s:hl('PmenuSbar',  '',     s:p.selection)
call s:hl('PmenuThumb', '',     s:p.fg)
" }}}

" Spell {{{
call s:hl('SpellBad',   s:p.red,    '')
call s:hl('SpellCap',   s:p.yellow, '')
call s:hl('SpellLocal', s:p.yellow, '')
call s:hl('SpellRare',  s:p.yellow, '')
" }}}

" Statusline & Tabline {{{
call s:hl('StatusLine',   s:p.blue,       s:p.cursor_line)
call s:hl('StatusLineNC', s:p.comment_fg, s:p.cursor_line)
call s:hl('TabLine',      s:p.comment_fg, s:p.cursor_line)
call s:hl('TabLineFill',  s:p.comment_fg, s:p.cursor_line)
call s:hl('TabLineSel',   s:p.fg,         s:p.bg)
" }}}

" Visual {{{
call s:hl('Visual',       s:p.bg, s:p.selection)
call s:hl('VisualNOS',    '',     s:p.selection)
call s:hl('TextYankPost', s:p.bg, s:p.textyankpost)
" }}}

" Syntax Highlighting {{{
call s:hl('Comment',        s:p.comment_fg,  '')
call s:hl('Constant',       s:p.purple,      '')
call s:hl('String',         s:p.yellow,      '')
call s:hl('Character',      s:p.yellow,      '')
call s:hl('Number',         s:p.green,       '')
call s:hl('Boolean',        s:p.green,       '')
call s:hl('Float',          s:p.green,       '')
call s:hl('Identifier',     s:p.blue,        '')
call s:hl('Function',       s:p.orange,      '')
call s:hl('Statement',      s:p.cyan,        '')
call s:hl('Conditional',    s:p.cyan,        '')
call s:hl('Repeat',         s:p.cyan,        '')
call s:hl('Label',          s:p.cyan,        '')
call s:hl('Operator',       s:p.punctuation, '')
call s:hl('Keyword',        s:p.cyan,        '')
call s:hl('Exception',      s:p.cyan,        '')
call s:hl('PreProc',        s:p.yellow,      '')
call s:hl('Include',        s:p.cyan,        '')
call s:hl('Define',         s:p.cyan,        '')
call s:hl('Macro',          s:p.purple,      '')
call s:hl('PreCondit',      s:p.yellow,      '')
call s:hl('Type',           s:p.yellow,      '')
call s:hl('StorageClass',   s:p.yellow,      '')
call s:hl('Structure',      s:p.yellow,      '')
call s:hl('Typedef',        s:p.yellow,      '')
call s:hl('Special',        s:p.red,         '')
call s:hl('SpecialChar',    s:p.fg,          '')
call s:hl('Tag',            s:p.fg,          '')
call s:hl('Delimiter',      s:p.punctuation, '')
call s:hl('SpecialComment', s:p.fg,          '')
call s:hl('Debug',          s:p.fg,          '')
call s:hl('Underlined',     s:p.fg,          '', 'underline')
call s:hl('Ignore',         s:p.fg,          '')
call s:hl('Error',          s:p.red,         s:p.gutter_bg)
call s:hl('Todo',           s:p.purple,      '')
" }}}

" GitSigns {{{
call s:hl('GitSignsAdd',              s:p.green,      s:p.gutter_bg)
call s:hl('GitSignsDelete',           s:p.red,        s:p.gutter_bg)
call s:hl('GitSignsChange',           s:p.yellow,     s:p.gutter_bg)
call s:hl('GitSignsCurrentLineBlame', s:p.comment_fg, s:p.gutter_bg)
" }}}

" Fugitive {{{
call s:hl('diffAdded',   '#5fae4d', '')
call s:hl('diffRemoved', '#e22f62', '')
" }}}

" Git Commit {{{
call s:hl('gitcommitComment',       s:p.comment_fg, '')
call s:hl('gitcommitUnmerged',      s:p.red,        '')
call s:hl('gitcommitOnBranch',      s:p.fg,         '')
call s:hl('gitcommitBranch',        s:p.purple,     '')
call s:hl('gitcommitDiscardedType', s:p.red,        '')
call s:hl('gitcommitSelectedType',  s:p.green,      '')
call s:hl('gitcommitHeader',        s:p.fg,         '')
call s:hl('gitcommitUntrackedFile', s:p.cyan,       '')
call s:hl('gitcommitDiscardedFile', s:p.red,        '')
call s:hl('gitcommitSelectedFile',  s:p.green,      '')
call s:hl('gitcommitUnmergedFile',  s:p.yellow,     '')
call s:hl('gitcommitFile',          s:p.fg,         '')

call s:link('gitcommitNoBranch',       'gitcommitBranch')
call s:link('gitcommitUntracked',      'gitcommitComment')
call s:link('gitcommitDiscarded',      'gitcommitComment')
call s:link('gitcommitSelected',       'gitcommitComment')
call s:link('gitcommitDiscardedArrow', 'gitcommitDiscardedFile')
call s:link('gitcommitSelectedArrow',  'gitcommitSelectedFile')
call s:link('gitcommitUnmergedArrow',  'gitcommitUnmergedFile')
" }}}

" Git Messenger {{{
call s:hl('gitmessengerPopupNormal', '', '#000000')
call s:link('gitmessengerHeader',   'Identifier')
call s:link('gitmessengerHash',     'Number')
call s:link('gitmessengerHistory',  'Constant')
" }}}

" Conflict Marker {{{
call s:hl('ConflictMarkerBegin',     '', '#2f7366')
call s:hl('ConflictMarkerOurs',      '', '#2e5049')
call s:hl('ConflictMarkerSeparator', '#e5c07b', '')
call s:hl('ConflictMarkerTheirs',    '', '#344f69')
call s:hl('ConflictMarkerEnd',       '', '#2f628e')
" }}}

" Coc.nvim {{{
call s:hl('CocFloating',         '', '#282829')
call s:hl('CocErrorHighlight',   '#dd3c69', '')
call s:hl('CocWarningHighlight', '#d6b152', '')
call s:hl('CocHintHighlight',    '#ffffff', '', 'underline')
call s:hl('CocHintSign',         '#55CABE', '')
call s:link('CocErrorSign',   'CocErrorHighlight')
call s:link('CocWarningSign', 'CocWarningHighlight')
" }}}

" Clever-f {{{
call s:hl('CleverFDefaultLabel', '#ffb300', '', 'bold,underline')
call s:hl('CleverFDirect',       '#ffb300', '', 'bold')
" }}}

" CtrlSF {{{
call s:link('ctrlsfMatch',     'Search')
call s:link('ctrlsfLnumMatch', 'LineNr')
" }}}

" vim-sneak {{{
call s:hl('Sneak',      '#000000', '#ffffff')
call s:hl('SneakScope', '#ffffff', '#28c9ff')
" }}}

" HighlightedYank {{{
call s:hl('HighlightedyankRegion', '#ffffff', '#e5c07b', 'bold')
" }}}

" vim-log-highlighting {{{
call s:link('logNumber',           'Directory')
call s:link('logHexNumber',        'Directory')
call s:link('logBinaryNumber',     'Directory')
call s:link('logFloatNumber',      'Directory')
call s:link('logBoolean',          'Boolean')
call s:link('logNull',             'Constant')
call s:link('logString',           'String')
call s:link('logDate',             'Directory')
call s:link('logDateDay',          'Directory')
call s:link('logTime',             'Directory')
call s:link('logTimeZone',         'Directory')
call s:link('logUrl',              'Underlined')
call s:link('logDomain',           'Label')
call s:link('logUUID',             'Label')
call s:link('logMD5',              'Label')
call s:link('logIPV4',             'Label')
call s:link('logIPV6',             'ErrorMsg')
call s:link('logMacAddress',       'Label')
call s:link('logFilePath',         'Conditional')
call s:link('logSysColumns',       'Conditional')
call s:link('logSysProcess',       'Include')
call s:link('logXmlHeader',        'Function')
call s:link('logXmlDoctype',       'Function')
call s:link('logXmlTag',           'Identifier')
call s:link('logXmlAttribute',     'Type')
call s:link('logXmlNamespace',     'Include')
call s:link('logXmlComment',       'Comment')
call s:link('logXmlCData',         'String')
call s:link('logXmlEntity',        'Special')
call s:link('logOperator',         'Operator')
call s:link('logBrackets',         'Comment')
call s:link('logEmptyLines',       'Comment')
call s:link('logLevelEmergency',   'ErrorMsg')
call s:link('logLevelAlert',       'ErrorMsg')
call s:link('logLevelCritical',    'ErrorMsg')
call s:link('logLevelError',       'ErrorMsg')
call s:link('logLevelWarning',     'WarningMsg')
call s:link('logLevelNotice',      'Character')
call s:link('logLevelInfo',        'DiffAdd')
call s:link('logLevelDebug',       'Comment')
call s:link('logLevelTrace',       'Comment')
" }}}

" vim:foldmethod=marker:foldlevel=0

