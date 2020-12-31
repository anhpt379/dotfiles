function! floaterm#wrapper#gb#(cmd) abort
  return ['/usr/local/bin/fish -c gb', {}, v:false]
endfunction
