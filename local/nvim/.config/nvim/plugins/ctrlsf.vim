nmap <C-s><C-f> :CtrlSF -- ""<Left>
vmap <C-s><C-f> <Plug>CtrlSFVwordExec

let g:ctrlsf_default_root = 'project'
let g:ctrlsf_ignore_dir = ['.git']
let g:ctrlsf_case_sensitive = 'yes'
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_confirm_unsaving_quit = 0
let g:ctrlsf_position = 'left'
let g:ctrlsf_indent = 2
let g:ctrlsf_auto_close = 0
let g:ctrlsf_auto_focus = { 'at' : 'start' }
let g:ctrlsf_auto_preview = 0
let g:ctrlsf_winsize = '100%'
let g:ctrlsf_backend = 'rg'
let g:ctrlsf_follow_symlinks = 0
let g:ctrlsf_search_mode = 'sync'
let g:ctrlsf_extra_backend_args = {
  \ 'rg': '--fixed-strings --hidden --glob "!.git"'
  \ }
let g:ctrlsf_mapping = {
  \   'open'    : '',
  \   'openb'   : '',
  \   'split'   : '',
  \   'vsplit'  : '',
  \   'tab'     : '',
  \   'tabb'    : '',
  \   'popen'   : '',
  \   'popenf'  : '',
  \   'quit'    : 'q',
  \   'next'    : 'n',
  \   'prev'    : 'N',
  \   'pquit'   : 'q',
  \   'loclist' : '',
  \   'chgmode' : '',
  \   'stop'    : '<C-C>',
  \ }

