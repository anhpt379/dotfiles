if exists('g:puppet_go_to_definition')
  finish
endif

function! PuppetGoToDefinition()
  let isk_save = &l:isk

  " [Class['::foo::bar']], file('/path/to/file.sh'), $::is_staging
  " include ::profile_base
  setlocal iskeyword+=:,.,/,],[,',\",\$,-
  let cword = expand('<cword>')
  let &l:isk = isk_save

  let tag_name = substitute(trim(cword, ':"'''), "'::", "'", '')
  let tag_len = len(tag_name)
  if tag_name[0] ==# '['
    let tag_name = tag_name[1:tag_len]
    let tag_len = len(tag_name)
  endif
  if tag_name[tag_len-2:tag_len-1] ==# ']]'
    let tag_name = tag_name[0:tag_len-2]
  endif

  echo tag_name
  exec('silent! tag ' . tag_name)
endfunction

let g:puppet_go_to_definition = 1

map gd :call PuppetGoToDefinition()<CR>
