scriptencoding utf-8

" Enable true color support (must be set before loading colorscheme)
if has('termguicolors')
  set termguicolors
endif

" Colorscheme
colorscheme aodark

" Text yanking highlight
autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="TextYankPost", timeout=700}

" Indentline
let g:indentLine_char = '┊'
let g:indentLine_setConceal = 0

