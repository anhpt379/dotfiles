function! FZF()
  call TermOpen('f', '/tmp/fzf_selected_files')
endfunction

function! FZFRg(is_visual) abort
  let l:query = ''
  if a:is_visual
    " Get visual selection text
    let l:start = getpos("'<")
    let l:end = getpos("'>")
    let l:lines = getline(l:start[1], l:end[1])
    if len(l:lines) == 1
      let l:query = strpart(l:lines[0], l:start[2] - 1, l:end[2] - l:start[2] + 1)
    else
      let l:lines[0] = strpart(l:lines[0], l:start[2] - 1)
      let l:lines[-1] = strpart(l:lines[-1], 0, l:end[2])
      let l:query = join(l:lines, ' ')
    endif
  endif
  " If still empty (normal mode or empty selection), ask for input
  if empty(l:query)
    let l:query = input('FZFRg> ')
  endif
  if !empty(l:query)
    call TermOpen('f "' . l:query . '"', '/tmp/fzf_selected_files')
  endif
endfunction

function! Lf()
  call TermOpen('echo "" > /tmp/lf_selected_files && lf --selection-path /tmp/lf_selected_files ' . expand('%:p'), '/tmp/lf_selected_files')
endfunction

" FZF mappings
nnoremap <silent> <leader>g :call FZFRg(v:false)<CR>
vnoremap <silent> <leader>g :<C-u>call FZFRg(v:true)<CR>
noremap <Leader>l :call Lf()<CR>
noremap <Leader>f :call FZF()<CR>
