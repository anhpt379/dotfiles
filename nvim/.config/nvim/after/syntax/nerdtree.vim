" Fix NERDTree devicons colors
syntax clear NERDTreeFlags

" Add grep menu to NERDTree
if exists("g:loaded_nerdtree_grep_menuitem")
    finish
endif
let g:loaded_nerdtree_grep_menuitem = 1

call NERDTreeAddMenuItem({
  \ 'text': '(g)rep directory',
  \ 'shortcut': 'g',
  \ 'callback': 'NERDTreeRg'
  \ })

function! NERDTreeRg()
  let dirnode = g:NERDTreeDirNode.GetSelected()
  echo dirnode.path.str()

  let pattern = input('Enter the search pattern: ')
  if pattern ==# ''
    echo 'Aborted'
    return
  endif

  execute ':NERDTreeClose'

  execute ':FzfRg "' . pattern . '" ' . dirnode.path.str()
endfunction

