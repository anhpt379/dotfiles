let g:startify_disable_at_vimenter = 0
nmap <Leader>s :Startify<CR>
let g:startify_change_to_dir = 0
let g:startify_fortune_use_unicode = 1
let g:startify_enable_special = 0
let g:startify_update_oldfiles = 1
let g:startify_lists = [
  \ {'header': ['   MRU '. getcwd()], 'type': 'dir'},
  \ {'header': ['   Bookmarks'],      'type': 'bookmarks'},
  \ {'header': ['   Sessions'],       'type': 'sessions'},
  \ ]
let g:startify_bookmarks = [
  \ {'b': '~/dotfiles/macOS/brew/.Brewfile'},
  \ {'f': '~/dotfiles/local/fish/.config/fish/config.fish'},
  \ {'t': '~/dotfiles/local/tmux/.tmux.conf'},
  \ {'v': '~/dotfiles/local/nvim/.config/nvim/init.vim'},
  \ ]

augroup startified
  autocmd!
  autocmd User Startified setlocal cursorline
  autocmd User Startified nmap <buffer> o <plug>(startify-open-buffers)
  autocmd User Startified nmap <buffer> q :q!<CR>
augroup end

function! StartifyEntryFormat()
  return "WebDevIconsGetFileTypeSymbol(absolute_path) . ' ' . entry_path"
endfunction

