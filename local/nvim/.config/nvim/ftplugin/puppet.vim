" Disable auto wrap long lines
setlocal formatexpr=

" Go to definition
function! PuppetGoToDefinition()
  let isk_save = &l:isk
  " [Class['::foo::bar']], file('/path/to/file.sh'), $::is_staging
  " include ::profile_base
  setlocal iskeyword+=:,.,/,],[,',\",\$,-
  let cword = expand('<cword>')
  let &l:isk = isk_save
  let tag_name = cword
  " Removing single/double quotes, and `::` from the tag name
  let tag_name = substitute(tag_name, ':$', '', '')
  let tag_name = substitute(tag_name, '^"', '', '')
  let tag_name = substitute(tag_name, '"$', '', '')
  let tag_name = substitute(tag_name, "^'", '', '')
  let tag_name = substitute(tag_name, "'$", '', '')
  let tag_name = substitute(tag_name, '^::', '', '')
  let tag_name = substitute(tag_name, '^[', '', '')
  let tag_name = substitute(tag_name, ']]$', ']', '')
  echo tag_name
  exec('silent! tag ' . tag_name)
endfunction

nnoremap <buffer> <C-]> :call PuppetGoToDefinition()<CR>

