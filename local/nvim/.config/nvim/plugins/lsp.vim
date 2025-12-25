" LSP mappings
nmap gd       :lua vim.lsp.buf.declaration()<CR>
nmap gD       :lua vim.lsp.buf.definition()<CR>
nmap K        :lua vim.lsp.buf.hover()<CR>
nmap <Space>r :lua vim.lsp.buf.rename()<CR>

" Navigate diagnostics
" <C-jk> to jump between diagnostics
map <C-j> :lua vim.diagnostic.goto_next()<CR>
map <C-k> :lua vim.diagnostic.goto_prev()<CR>

" Jump to next/prev diagnostic from INSERT mode also
imap <silent> <PageDown> <Esc><PageDown>
imap <silent> <PageUp> <Esc><PageUp>

" Accept completion with <CR> and <Tab>
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
inoremap <expr> <Tab> pumvisible() ? '<C-y> ' : '<C-g>u<Tab>'

