" Disable continuation of comments to the next line
augroup format-options
  autocmd!
  autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup end

" Auto create dirs on save
function! s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction

augroup auto-create-dir
  autocmd!
  autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup end

" Custom file extensions / syntax highlighting
augroup custom-file-extensions
  autocmd!
  autocmd BufReadPost *.rules set filetype=yaml
  autocmd BufReadPost *.eyaml set filetype=yaml
augroup end

" Format code on file save
function! FormatCode()
  let file = expand('%:p')
  if !filewritable(file)
    return
  endif
  noautocmd write
  let script_file =
        \ system('git rev-parse --show-toplevel')[:-2] .
        \ '/scripts/format-' . &filetype . '.sh'
  if v:shell_error != 0 || !filereadable(script_file)
    return
  endif
  let output = system(script_file . ' ' . file)
  if v:shell_error == 0
    let view = winsaveview()
    edit
    call winrestview(view)
  else
    echo output
  endif
endfunction

augroup format_code_on_save
  autocmd!
  autocmd BufWritePre *.tf,*.tfvars Neoformat
  autocmd BufWriteCmd *.pp call FormatCode()
  autocmd BufWriteCmd *.yaml,*.eyaml,*.yml call FormatCode()
augroup end

" Persist and provide a clearer message for external file changes
augroup FCSHandler
  autocmd!
  autocmd FileChangedShell * call FCSHandler(expand('<afile>:p'))
augroup end

function! FCSHandler(name)
  let msg = 'File "'.a:name.'"'
  let v:fcs_choice = ''
  if v:fcs_reason ==# 'deleted'
    let msg .= ' no longer available'
  elseif v:fcs_reason ==# 'time'
    let msg .= ' timestamp changed'
  elseif v:fcs_reason ==# 'mode'
    let msg .= ' permissions changed'
  elseif v:fcs_reason ==# 'changed'
    let msg .= ' contents changed'
    let v:fcs_choice = 'ask'
  elseif v:fcs_reason ==# 'conflict'
    let msg .= ' CONFLICT --'
    let msg .= ' is modified, but'
    let msg .= ' was changed outside Vim'
    let v:fcs_choice = 'ask'
    echohl Error
  else  " unknown values (future Vim versions?)
    let msg .= ' FileChangedShell reason='
    let msg .= v:fcs_reason
    let v:fcs_choice = 'ask'
  endif
  redraw!
  echohl Error
  echon msg
  echohl None
endfunction

" Copy text to clipboard on focus lost
augroup copy_text_to_clipboard_on_focus_lost
  autocmd!
  autocmd BufLeave,FocusLost * silent! normal! ygv
augroup end

" Disable whitespace highlighting for certain filetypes
function! DisableWhitespace()
  if &filetype =~# 'fugitive\|startify\|ctrlsf\|git\|man\|log'
    DisableWhitespace
  endif
endfunction

augroup disable-whitespace
  autocmd!
  autocmd FileType * call DisableWhitespace()
augroup end

" CtrlSF after window init
augroup ctrlsf-key-mappings
  autocmd!
  autocmd FileType ctrlsf nmap <buffer> gw :w<CR>
augroup end

func! CtrlSFAfterMainWindowInit()
  silent! nnoremap <silent><buffer> <Enter> :call ctrlsf#JumpTo('open') \| call ctrlsf#win#FocusMainWindow()<CR>
endfunc

