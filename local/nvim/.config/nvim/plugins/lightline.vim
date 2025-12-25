let g:lightline = {
  \ 'colorscheme': 'aodark',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['gitbranch', 'readonly', 'modified'],
  \     ['lsp_status', 'where_am_i']
  \   ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'DevIconsFugitiveHead',
  \   'filetype': 'DevIconsFileType',
  \   'fileformat': 'DevIconsFileFormat',
  \   'lsp_status': 'LspStatus',
  \   'where_am_i': 'Whereami',
  \ },
  \ }

function! LspStatus() abort
  if has_key(b:, 'lightline_lspstatus') &&
      \ reltimestr(reltime(b:lightline_lspstatus_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_lspstatus
  endif
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    let lspstatus = luaeval("require('lsp-status').status()")
    let b:lightline_lspstatus = lspstatus
    let b:lightline_lspstatus_time = reltime()
    return b:lightline_lspstatus
  endif
  return ''
endfunction

function! Whereami() abort
  if has_key(b:, 'lightline_whereami') &&
      \ reltimestr(reltime(b:lightline_whereami_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_whereami
  endif
  let location = luaeval("require'nvim-navic'.is_available()") ?
    \ luaeval("require'nvim-navic'.get_location()") : ''
  let b:lightline_whereami = location
  let b:lightline_whereami_time = reltime()
  return b:lightline_whereami
endfunction

function! DevIconsFugitiveHead()
  if has_key(b:, 'lightline_fugitive') &&
      \ reltimestr(reltime(b:lightline_fugitive_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_fugitive
  endif
  let branch = FugitiveHead()
  if empty(branch)
    return ''
  endif
  let head = ' ' . branch
  let b:lightline_fugitive = head
  let b:lightline_fugitive_time = reltime()
  return b:lightline_fugitive
endfunction

function! DevIconsFileType()
  if has_key(b:, 'lightline_devicons_filetype') &&
      \ reltimestr(reltime(b:lightline_devicons_filetype_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_devicons_filetype
  endif
  let filetype = winwidth(0) > 70 ?
        \ (strlen(&filetype) ?
        \  WebDevIconsGetFileTypeSymbol() . ' ' . &filetype : 'no ft') : ''
  let b:lightline_devicons_filetype = filetype
  let b:lightline_devicons_filetype_time = reltime()
  return b:lightline_devicons_filetype
endfunction

function! DevIconsFileFormat()
  if has_key(b:, 'lightline_devicons_fileformat') &&
      \ reltimestr(reltime(b:lightline_devicons_fileformat_time)) =~# '^\s*0\.[0-5]'
    return b:lightline_devicons_fileformat
  endif
  let fileformat = winwidth(0) > 70 ?
        \ (WebDevIconsGetFileFormatSymbol() . ' ' . &fileformat) : ''
  let b:lightline_devicons_fileformat = fileformat
  let b:lightline_devicons_fileformat_time = reltime()
  return b:lightline_devicons_fileformat
endfunction

" Show vim tab line even if only one file is open
if g:hostname =~# 'fedora'
  set showtabline=2
  map <C-n> :<C-u>execute 'normal gq' \| bnext<CR>
  map <C-p> :<C-u>execute 'normal gq' \| bprevious<CR>
  map <Up>  :<C-u>execute 'normal gq' \| bprevious<CR>
  nmap ` <C-^>
  let g:lightline#bufferline#show_number     = 0
  let g:lightline#bufferline#shorten_path    = 1
  let g:lightline#bufferline#unnamed         = '[No Name]'
  let g:lightline#bufferline#enable_devicons = 1
  let g:lightline#bufferline#unicode_symbols = 1
  let g:lightline#bufferline#modified        = ' '
  let g:lightline#bufferline#read_only       = ' 󰈡'
  let g:lightline#bufferline#clickable       = 1
  let g:lightline.separator                  = { 'left': '', 'right': '' }
  let g:lightline.subseparator               = { 'left': '', 'right': '' }
  let g:lightline.tabline          = {'left': [['buffers']], 'right': []}
  let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
  let g:lightline.component_type   = {'buffers': 'tabsel'}
  let g:lightline.component_raw    = {'buffers': 1}
endif

