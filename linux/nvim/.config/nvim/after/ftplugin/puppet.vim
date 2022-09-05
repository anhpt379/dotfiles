if exists('g:puppet_jump')
  finish
endif

function! Jump()
  let isk_save = &l:isk
  setlocal iskeyword+=:,.,/,],[,',\",\$,-
  let cword = expand('<cword>')
  let &l:isk = isk_save

  let tag_name = substitute(trim(cword, ':"'''), "'::", "'", '')
  if tag_name[0] ==# '[' && tag_name[len(tag_name) - 1] ==# ']'
    let tag_name = tag_name[1:len(tag_name) - 2]
  endif

  echo tag_name
  exec('tag ' . tag_name)
endfunction

let g:puppet_jump = 1

map gd :call Jump()<CR>
