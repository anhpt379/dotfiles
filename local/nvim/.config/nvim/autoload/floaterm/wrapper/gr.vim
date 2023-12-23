function! floaterm#wrapper#gr#(cmd, jobopts, config) abort
  return [v:false, '/bin/bash -c gr']
endfunction
