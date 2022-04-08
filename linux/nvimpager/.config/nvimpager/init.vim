colorscheme aodark

set clipboard+=unnamedplus

set nowrap

set incsearch
set ignorecase
set smartcase

lua nvimpager.maps = false

nmap C /commit [a-z0-9]\{40}\\|added: .\+$\\|deleted: .\+$\\|modified: .\+$<CR>
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

" Hide `E211: file no longer available` on `cat <file> | nvimpager -p`
augroup suppress-file-no-longer-available-warning
  autocmd FileChangedShell * :
augroup end
