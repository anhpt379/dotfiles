function! floaterm#wrapper#gb#(cmd) abort
  return ['/bin/bash -c gb', {}, v:false]
endfunction
