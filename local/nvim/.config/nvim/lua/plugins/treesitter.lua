-- Treesitter and related plugins

-- Fix slow cursor movement on jinja2 files
vim.g.matchup_matchparen_deferred = 1

-- Autoclose and autorename HTML tags
require('nvim-ts-autotag').setup()

-- Context-aware comment strings
vim.g.skip_ts_context_commentstring_module = true
require('ts_context_commentstring').setup({
  enable_autocmd = false,
})

-- Main treesitter configuration
require('nvim-treesitter').setup({
  ensure_installed = {
    "bash", "css", "csv", "diff", "editorconfig", "fish",
    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    "go", "gomod", "gosum", "gotmpl", "gowork", "gpg", "graphql",
    "helm", "hjson", "hlsplaylist", "html", "htmldjango", "http",
    "ini", "java", "javascript", "jq", "jsdoc", "json", "json5", "jsonc", "jsonnet",
    "lua", "luadoc", "make", "markdown", "nginx", "ninja", "nix",
    "passwd", "pem", "perl", "php", "promql", "puppet", "python",
    "readline", "regex", "requirements", "ruby", "rust", "scss", "sql",
    "ssh_config", "strace", "svelte", "swift", "terraform", "tmux", "toml",
    "tsv", "tsx", "vim", "vimdoc", "vue", "xml", "yaml", "zig",
  },
  sync_install = false,
  highlight = {
    enable = false,
  },
  matchup = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v',
        ['@function.outer'] = 'V',
        ['@class.outer'] = '<c-v>',
      },
      include_surrounding_whitespace = false,
    },
  },
})

