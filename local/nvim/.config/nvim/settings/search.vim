" Search behavior
set ignorecase
set smartcase

" Live substitution
set inccommand=split

" Clear search highlighting by pressing Enter/Esc
nnoremap <CR>  :nohlsearch<CR>
nnoremap <Esc> :nohlsearch<CR><Esc>

" Vim searchhi
map n   <Plug>(searchhi-n)zz<Plug>SearchIndex
map N   <Plug>(searchhi-N)zz<Plug>SearchIndex
map *   <Plug>(asterisk-*)zz<Plug>(searchhi-update)
map #   <Plug>(asterisk-#)zz<Plug>(searchhi-update)
map g*  <Plug>(asterisk-g*)zz<Plug>(searchhi-update)
map g#  <Plug>(asterisk-g#)zz<Plug>(searchhi-update)
map z*  <Plug>(asterisk-z*)zz<Plug>(searchhi-update)
map z#  <Plug>(asterisk-z#)zz<Plug>(searchhi-update)
map gz* <Plug>(asterisk-gz*)zz<Plug>(searchhi-update)
map gz# <Plug>(asterisk-gz#)zz<Plug>(searchhi-update)

let g:searchhi_clear_all_asap = 1

nmap / <Plug>(searchhi-/)\V
nmap ? <Plug>(searchhi-?)\V
vmap / <Plug>(searchhi-v-/)\V
vmap ? <Plug>(searchhi-v-?)\V

" Faster search & replace with <C-r>
nnoremap <C-r> :%s;<C-r><C-w>;;<Left>
vnoremap <C-r> "hy:%s;<C-r>h;;<Left>

