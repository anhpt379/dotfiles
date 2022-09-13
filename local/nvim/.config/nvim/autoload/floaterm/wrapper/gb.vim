function! floaterm#wrapper#gb#(cmd, jobopts, config) abort
  return [v:false, '/bin/bash -c gb']
endfunction
