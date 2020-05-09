set background=dark
highlight clear
syntax reset

let g:colors_name='aodark'
let colors_name='aodark'


let s:black       = { 'gui': '#1C1E23', 'cterm': '236' }
let s:red         = { 'gui': '#DE456B', 'cterm': '168' }
let s:green       = { 'gui': '#8DC26C', 'cterm': '114' }
let s:yellow      = { 'gui': '#E2B962', 'cterm': '180' }
let s:blue        = { 'gui': '#3BB0E0', 'cterm': '75'  }
let s:purple      = { 'gui': '#C068DF', 'cterm': '176' }
let s:cyan        = { 'gui': '#55CABE', 'cterm': '73'  }
let s:white       = { 'gui': '#F1F1F1', 'cterm': '188' }

let s:fg          = s:white
let s:bg          = s:black

let s:comment_fg  = { 'gui': '#696969', 'cterm': '241' }
let s:gutter_bg   = { 'gui': '#282c34', 'cterm': '236' }
let s:gutter_fg   = { 'gui': '#919baa', 'cterm': '247' }

let s:cursor_line = { 'gui': '#282c34', 'cterm': '237' }
let s:color_col   = { 'gui': '#282c34', 'cterm': '237' }

let s:selection   = { 'gui': '#474e5d', 'cterm': '239' }
let s:vertsplit   = { 'gui': '#313640', 'cterm': '237' }


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


" User interface colors {
call s:h('Normal', s:fg, s:bg, '')
call s:h('NonText', s:fg, '', '')

call s:h('Cursor', s:bg, s:blue, '')
call s:h('CursorColumn', '', s:cursor_line, '')
call s:h('CursorLine', '', s:cursor_line, '')

call s:h('LineNr', s:gutter_fg, s:gutter_bg, '')
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

call s:h('Pmenu', s:bg, s:fg, '')
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
" }


" Syntax colors {
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
" }


" Plugins {
" GitGutter
call s:h('GitGutterAdd', s:green, s:gutter_bg, '')
call s:h('GitGutterDelete', s:red, s:gutter_bg, '')
call s:h('GitGutterChange', s:yellow, s:gutter_bg, '')
call s:h('GitGutterChangeDelete', s:red, s:gutter_bg, '')
" Fugitive
call s:h('diffAdded', s:green, '', '')
call s:h('diffRemoved', s:red, '', '')
" }


" Git {
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
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile
" }

" Fix colors in neovim terminal buffers {
  if has('nvim')
    let g:terminal_color_0 = s:black.gui
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
" }

" Lightline {{{

let s:mono0 = [ '#282c34', 236 ]
let s:mono1 = [ '#313640', 238 ]
let s:mono2 = [ '#5d677a', 243 ]
let s:mono3 = [ '#dcdfe4', 255 ]

let s:yellow = [ '#E2B962', 180 ]
let s:red = [ '#DE456B', 168 ]
let s:magenta = [ '#C068DF', 176 ]
let s:blue = [ '#3BB0E0', 75 ]
let s:cyan = [ '#55CABE', 73 ]
let s:green = [ '#8DC26C', 114 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:mono0, s:green ], [ s:mono3, s:mono2 ] ]
let s:p.normal.middle = [ [ s:mono3, s:mono1 ] ]
let s:p.normal.right = [ [ s:mono0, s:mono3 ], [ s:mono3, s:mono2 ] ]

let s:p.normal.error = [ [ s:mono0, s:red ] ]
let s:p.normal.warning = [ [ s:mono0, s:yellow ] ]

let s:p.inactive.left =  [ [ s:mono3, s:mono2 ], [ s:mono3, s:mono2 ] ]
let s:p.inactive.middle = [ [ s:mono3, s:mono1 ] ]
let s:p.inactive.right = [ [ s:mono0, s:mono3 ], [ s:mono3, s:mono2 ] ]

let s:p.insert.left = [ [ s:mono0, s:blue ], [ s:mono3, s:mono2 ] ]
let s:p.replace.left = [ [ s:mono0, s:red ], [ s:mono3, s:mono2 ] ]
let s:p.visual.left = [ [ s:mono0, s:yellow ], [ s:mono3, s:mono2 ] ]

let s:p.tabline.left = [ [ s:mono2, s:mono1] ]
let s:p.tabline.tabsel = [ [ s:mono3, s:mono2 ] ]
let s:p.tabline.middle = [ [ s:mono2, s:mono1] ]
let s:p.tabline.right = [ [ s:mono0, s:mono3 ] ]

let g:lightline#colorscheme#aodark#palette = lightline#colorscheme#flatten(s:p)

" }}}

" NERDTree Devicons
let g:NERDTreeExtensionHighlightColor = {}
let g:NERDTreeExtensionHighlightColor['bat'       ] =  'ff8b52'
let g:NERDTreeExtensionHighlightColor['class'     ] =  '80cbc4'
let g:NERDTreeExtensionHighlightColor['conf'      ] =  '8cffba'
let g:NERDTreeExtensionHighlightColor['css'       ] =  'ffcde6'
let g:NERDTreeExtensionHighlightColor['deb'       ] =  'ffb340'
let g:NERDTreeExtensionHighlightColor['odt'       ] =  '7fff00'
let g:NERDTreeExtensionHighlightColor['doc'       ] =  '7fff00'
let g:NERDTreeExtensionHighlightColor['docx'      ] =  '7fff00'
let g:NERDTreeExtensionHighlightColor['dtd'       ] =  'ff2c4b'
let g:NERDTreeExtensionHighlightColor['ear'       ] =  'ffb340'
let g:NERDTreeExtensionHighlightColor['fxml'      ] =  'ff2c4b'
let g:NERDTreeExtensionHighlightColor['frxml'     ] =  'ff2c4b'
let g:NERDTreeExtensionHighlightColor['gif'       ] =  'f5c06f'
let g:NERDTreeExtensionHighlightColor['gradle'    ] =  '00c489' " gradle's logo color
let g:NERDTreeExtensionHighlightColor['groovy'    ] =  '4298b8'
let g:NERDTreeExtensionHighlightColor['gz'        ] =  'ffb340'
let g:NERDTreeExtensionHighlightColor['html'      ] =  '85ff66'
let g:NERDTreeExtensionHighlightColor['iml'       ] =  'ad8fcc'
let g:NERDTreeExtensionHighlightColor['jar'       ] =  'ffb340'
let g:NERDTreeExtensionHighlightColor['java'      ] =  '80cbc4'
let g:NERDTreeExtensionHighlightColor['jnlp'      ] =  'ad8fcc'
let g:NERDTreeExtensionHighlightColor['jpeg'      ] =  'F5C06F'
let g:NERDTreeExtensionHighlightColor['jpg'       ] =  'F5C06F'
let g:NERDTreeExtensionHighlightColor['js'        ] =  'ffa500'
let g:NERDTreeExtensionHighlightColor['lock'      ] =  'FFFF00'
let g:NERDTreeExtensionHighlightColor['markdown'  ] =  'B973FF'
let g:NERDTreeExtensionHighlightColor['md'        ] =  'B973FF'
let g:NERDTreeExtensionHighlightColor['mkd'       ] =  'B973FF'
let g:NERDTreeExtensionHighlightColor['php'       ] =  'ff00ff'
let g:NERDTreeExtensionHighlightColor['png'       ] =  'F5C06F'
let g:NERDTreeExtensionHighlightColor['properties'] =  '8cffba'
let g:NERDTreeExtensionHighlightColor['py'        ] =  '70d080'
let g:NERDTreeExtensionHighlightColor['rar'       ] =  'FFB340'
let g:NERDTreeExtensionHighlightColor['rpm'       ] =  'FFB340'
let g:NERDTreeExtensionHighlightColor['rs'        ] =  'FF7033'
let g:NERDTreeExtensionHighlightColor['rst'       ] =  'B973FF'
let g:NERDTreeExtensionHighlightColor['sql'       ] =  '66A3FF'
let g:NERDTreeExtensionHighlightColor['tags'      ] =  'ff6070'
let g:NERDTreeExtensionHighlightColor['ttf'       ] =  'd0eeff'
let g:NERDTreeExtensionHighlightColor['txt'       ] =  '444444'
let g:NERDTreeExtensionHighlightColor['vim'       ] =  'afd700'
let g:NERDTreeExtensionHighlightColor['war'       ] =  'FFB340'
let g:NERDTreeExtensionHighlightColor['xml'       ] =  'ff2c4b'
let g:NERDTreeExtensionHighlightColor['xls'       ] =  'ffff7d'
let g:NERDTreeExtensionHighlightColor['xlsx'      ] =  'ffff7d'
let g:NERDTreeExtensionHighlightColor['xsd'       ] =  'ff2c4b'
let g:NERDTreeExtensionHighlightColor['yaml'      ] =  'c8c8c8'
let g:NERDTreeExtensionHighlightColor['yml'       ] =  'c8c8c8'
let g:NERDTreeExtensionHighlightColor['zip'       ] =  'FFB340'
let g:NERDTreeExtensionHighlightColor['pp'        ] =  'E2B962'

