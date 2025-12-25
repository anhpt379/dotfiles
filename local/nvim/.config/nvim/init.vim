scriptencoding utf-8

source ~/.config/nvim/plugins.vim

" Load core settings
runtime settings/general.vim
runtime settings/appearance.vim
runtime settings/search.vim
runtime settings/autocmds.vim

" Load plugin configurations
runtime plugins/ctrlsf.vim
runtime plugins/editing.vim
runtime plugins/fugitive.vim
runtime plugins/fzf.vim
runtime plugins/lightline.vim
runtime plugins/lsp.vim
runtime plugins/startify.vim
runtime plugins/terminal.vim

" Load Lua config
if g:hostname =~# 'fedora'
  lua require('config')
endif
