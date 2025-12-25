autocmd TermOpen  * if g:hostname =~# 'fedora' | set showtabline=0 | endif | set nonumber | set signcolumn=no  | set laststatus=0 | :DisableWhitespace
autocmd TermLeave * if g:hostname =~# 'fedora' | set showtabline=2 | endif | set number   | set signcolumn=yes | set laststatus=2 | :EnableWhitespace

function! TermOpen(cmd, ...)
  let filepath = (a:0 >= 1 ? a:1 : '')
  set nowinfixbuf
  let callback = {}
  if !empty(filepath)
    let callback.filepath = filepath
  endif
  function! callback.on_exit(job_id, code, event)
    silent! Bclose!
    call s:close_gstatus()
    if has_key(self, 'filepath') && filereadable(self.filepath)
      let lines = readfile(self.filepath)
      for entry in lines
        let parts = split(entry, ':')
        if len(parts) >= 1 && filereadable(parts[0])
          execute 'edit ' . fnameescape(parts[0])
          if len(parts) >= 3 && str2nr(parts[1]) > 0 && str2nr(parts[2]) > 0
            call cursor(str2nr(parts[1]), str2nr(parts[2]))
          elseif len(parts) >= 2 && str2nr(parts[1]) > 0
            call cursor(str2nr(parts[1]), 1)
          endif
        endif
      endfor
    endif
  endfunction
  enew
  call termopen("printf '\e[5 q' && " . a:cmd, callback)
  startinsert
endfunction

" Note: s:close_gstatus is defined in fugitive.vim but used here
" You may need to move it to a shared location or duplicate it
function! s:close_gstatus()
  let l:total = winnr('$')
  for l:winnr in range(l:total, 1, -1)
    if l:total > 1 && !empty(getwinvar(l:winnr, 'fugitive_status'))
      execute l:winnr . 'close'
      let l:total -= 1
    endif
  endfor
endfunction

