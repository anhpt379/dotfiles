if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vim-plug
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup end
endif

let g:hostname = hostname()

call plug#begin()

  " Defaults everyone can agree on
  Plug 'tpope/vim-sensible'

  " Syntax highlighting
  Plug 'gisphm/vim-gitignore'
  Plug 'chr4/nginx.vim'
  Plug 'glench/vim-jinja2-syntax'
  Plug 'rodjek/vim-puppet'
  Plug 'pearofducks/ansible-vim'
  Plug 'ericpruitt/tmux.vim'
  Plug 'khaveesh/vim-fish-syntax'
  Plug 'CH-DanReif/haproxy.vim'
  Plug 'towolf/vim-helm'
  Plug 'anhpt379/vim-log-highlighting'
  Plug 'wgwoods/vim-systemd-syntax'
  Plug 'raimon49/requirements.txt.vim'
  Plug 'hashivim/vim-terraform'
  Plug 'VebbNix/lf-vim'
  Plug 'rhysd/vim-syntax-codeowners'

  " Fancy UI stuff
  Plug 'chrisbra/Colorizer'
  Plug 'ryanoasis/vim-devicons'
  Plug 'breuckelen/vim-resize'
  Plug 'rbgrouleff/bclose.vim'
  Plug 'roman/golden-ratio'

  " Improving editing experience
  Plug 'anhpt379/targets.vim'
  Plug 'michaeljsmith/vim-indent-object'
  Plug 'tpope/vim-repeat'
  Plug 'inkarkat/vim-visualrepeat'
  Plug 'kylechui/nvim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'farmergreg/vim-lastplace'
  Plug 'paretje/suda.vim'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-unimpaired'
  Plug 'folke/flash.nvim', {'tag': 'stable'}
  Plug 'junegunn/vim-easy-align'
  Plug 'cohama/lexima.vim'
  Plug 'tpope/vim-speeddating'
  Plug 'anhpt379/vim-dispatch'
  Plug 'qxxxb/vim-searchhi'
  Plug 'NMAC427/guess-indent.nvim'
  Plug 'kana/vim-niceblock'
  Plug 'haya14busa/vim-asterisk'
  Plug 'google/vim-searchindex'
  Plug 'junegunn/vim-after-object'
  Plug 'jeetsukumaran/vim-indentwise'
  Plug 'anhpt379/ctrlsf.vim'
  Plug 'anhpt379/vim-move'
  Plug 'tyru/open-browser.vim'
  Plug 'svban/YankAssassin.vim'
  Plug 'mireq/large_file'

  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'shumphrey/fugitive-gitlab.vim'

  " Heavily loaded plugins
  if g:hostname =~# 'fedora'
    Plug 'dstein64/vim-startuptime'
    Plug 'mhinz/vim-startify'
    Plug 'itchyny/lightline.vim'
    Plug 'mengelbrecht/lightline-bufferline'

    Plug 'mechatroner/rainbow_csv'
    Plug 'fladson/vim-kitty'

    Plug 'echasnovski/mini.indentscope', { 'branch': 'stable' } | Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }
    Plug 'norcalli/nvim-colorizer.lua'

    " Plug 'Saghen/blink.cmp', {'tag': 'v0.6.2', 'do': 'cargo +nightly build --release'}
    " Plug 'Saghen/blink.compat' | Plug 'anhpt379/cmp-mocword' | Plug 'anhpt379/plenary.nvim'
    " Plug 'mikavilpas/blink-ripgrep.nvim'

    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim' | Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    " Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'dmitmel/cmp-cmdline-history'
    Plug 'ray-x/cmp-treesitter'
    Plug 'lukas-reineke/cmp-rg'
    Plug 'davidsierradz/cmp-conventionalcommits'
    Plug 'anhpt379/cmp-mocword' | Plug 'anhpt379/plenary.nvim'
    Plug 'nvimtools/none-ls.nvim' | Plug 'anhpt379/plenary.nvim'
    Plug 'ray-x/cmp-treesitter'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'nvim-lua/lsp-status.nvim'
    Plug 'RRethy/nvim-treesitter-endwise'

    Plug 'lewis6991/gitsigns.nvim' | Plug 'anhpt379/plenary.nvim'

    Plug 'folke/trouble.nvim' | Plug 'kyazdani42/nvim-web-devicons'

    Plug 'sbdchd/neoformat'
    Plug 'pechorin/any-jump.vim'

    " Fix nvim not responding when opening typescript files
    " https://www.reddit.com/r/vim/comments/jm218c/comment/ghddi8p/
    Plug 'leafgarland/typescript-vim'
    Plug 'peitalin/vim-jsx-typescript'
    Plug 'othree/yajs.vim'

    " For vsnip users.
    " Plug 'hrsh7th/cmp-vsnip'
    " Plug 'hrsh7th/vim-vsnip'

    " For luasnip users.
    " Plug 'L3MON4D3/LuaSnip'
    " Plug 'saadparwaiz1/cmp_luasnip'

    " For ultisnips users.
    " Plug 'SirVer/ultisnips'
    " Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " For snippy users.
    " Plug 'dcampos/nvim-snippy'
    " Plug 'dcampos/cmp-snippy'

    Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/nvim-treesitter-textobjects', {'branch': 'main'}
    Plug 'SmiteshP/nvim-navic'
    Plug 'windwp/nvim-ts-autotag'
    Plug 'JoosepAlviste/nvim-ts-context-commentstring'
    Plug 'm-demare/hlargs.nvim'

    Plug 'anhpt379/conflict-marker.vim'
    Plug 'andymass/vim-matchup'
    Plug 'inkarkat/vim-EnhancedJumps' | Plug 'inkarkat/vim-ingo-library'

    Plug 'tpope/vim-obsession'

    Plug 'wakatime/vim-wakatime'
  endif

call plug#end()

