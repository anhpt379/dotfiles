lua nvimpager.maps = false

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
nmap c <nop>
nmap s <nop>
nmap I <nop>

map  q         :<C-u>qa!<CR>
nmap <Space>   <PageDown>
nmap <S-Space> <PageUp>
