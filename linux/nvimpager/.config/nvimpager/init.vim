set clipboard+=unnamedplus

set nowrap

set incsearch
set ignorecase
set smartcase

nmap C /^commit\|^added:\|^deleted:\|^modified:<CR>

nmap A ?Applied catalog in .* seconds<CR>

nmap <CR>  :nohlsearch<CR>
nmap <ESC> :nohlsearch<CR>

nmap H zH
nmap L zL
nmap h zh
nmap l zl

nmap a <nop>
nmap i <nop>

" Watch for file changes
" https://github.com/lucc/nvimpager/issues/21
set autoread
call timer_start(300, {id -> nvim_command("checktime")}, {"repeat": -1})
