require("large_file").setup()

-- indentscope
require('mini.indentscope').setup({
  draw = {
    delay = 10,
    animation = require('mini.indentscope').gen_animation.none(),
  },
  symbol = "▏"
})

-- flash.nvim
require("flash").setup({
  search = {
    forward = true,
    wrap = false,
    multi_window = false
  },
  modes = {
    char = {
      highlight = { backdrop = true },
      config = function(opts)
        opts.autohide = vim.fn.mode(true):find("no")
        -- Show jump labels not in operator-pending mode
        opts.jump_labels = not vim.fn.mode(true):find("o")
          and vim.v.count == 0
          and vim.fn.reg_executing() == ""
          and vim.fn.reg_recording() == ""
      end,
    }
  }
})

-- language servers
require("mason").setup {
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
}

require('mason-tool-installer').setup {
  ensure_installed = {
    'bash-language-server',
    'css-lsp',
    'dockerfile-language-server',
    'html-lsp',
    'pyright',
    'ansible-language-server',
    'json-lsp',
    'rust-analyzer',
    'lua-language-server',
    'terraform-ls',
    'solargraph',
    'tflint',
    'vim-language-server',
    'typescript-language-server',
  },
  auto_update = true,
  run_on_start = true,
  start_delay = 3000, -- 3 second delay
}

require("mason-lspconfig").setup_handlers({
  function (server_name)
    if server_name == 'sumneko_lua' then
      require("lspconfig")[server_name].setup {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          }
        }
      }
    elseif server_name == 'pyright' then
      require("lspconfig")[server_name].setup {
        settings = {
          python = {
            analysis = {
              diagnosticMode = 'openFilesOnly'
            }
          }
        }
      }
    else
      require("lspconfig")[server_name].setup {}
    end
  end,
})

require('lsp-status').register_progress()
require('lspconfig')

-- nvim-cmp
vim.o.pumheight = 15  -- nvim-cmp popup height

local cmp = require('cmp')

local kind_icons = {
  Text = '󰙩 ',
  Method = '',
  Function = '󰊕',
  Constructor = '',
  Field = '󰜢',
  Variable = '󰀫',
  Class = ' ',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '󰈙',
  Reference = ' ',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = '',
  Event = '',
  Operator = '󱓉',
  TypeParameter = '󰅲'
}

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = { },
  matching = {
    disallow_fuzzy_matching = false,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = true,
  },
  formatting = {
    fields = { 'kind', 'abbr' },
    format = function(_, vim_item)
      vim_item.kind = kind_icons[vim_item.kind] or ''
      vim_item.dup = 0
      return vim_item
    end,
  },
  sorting = {
    comparators = {
      function(...) return require('cmp_buffer'):compare_locality(...) end,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      -- cmp.config.compare.length,
      cmp.config.compare.order,
    }
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'treesitter' },
    { name = 'conventionalcommits' },
    { name = 'buffer', max_item_count = 3 },
    { name = 'mocword', max_item_count = 3 },
    {
      name = 'rg',
      max_item_count = 3,
      option = {
        cwd = vim.fn.expand('~/.config/nvim/dictionaries/hacker_news/'),
        debounce = 200,
        context_before = 0,
        context_after = 0,
      }
    },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'cmdline' },
--     { name = 'cmdline_history' },
--   })
-- })

local lsp_status = require('lsp-status')
lsp_status.register_progress()

lsp_status.config({
  current_function = false,
  kind_labels = kind_icons,
  status_symbol = '',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '',
  indicator_hint = '',
  indicator_ok = '',
})

-- null-ls.nvim
local null_ls = require('null-ls')
local sources = {
  null_ls.builtins.code_actions.gitsigns,

  null_ls.builtins.diagnostics.ansiblelint,
  null_ls.builtins.diagnostics.vint,
  null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.diagnostics.gitlint,
  null_ls.builtins.diagnostics.fish,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.markdownlint,
  null_ls.builtins.diagnostics.rubocop,
  null_ls.builtins.diagnostics.stylelint,
  null_ls.builtins.diagnostics.hadolint.with({ filetypes = { 'Dockerfile', 'dockerfile' } }),

  null_ls.builtins.formatting.clang_format,
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.fish_indent,
  null_ls.builtins.formatting.sqlformat,
  null_ls.builtins.formatting.shfmt,
  null_ls.builtins.formatting.cmake_format,
  null_ls.builtins.formatting.nginx_beautifier,
}
null_ls.setup({
  sources = sources,
  debug = true,
  log = {
    enable = true,
    level = 'debug',
    use_console = 'async',
  },
  update_in_insert = false,
})

local helpers = require('null-ls.helpers')
local languagetool = {
  name = 'languagetool',
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'markdown', 'gitcommit' },
  generator = null_ls.generator({
    command = vim.fn.expand('~/.config/nvim/bin/remote_languagetool.py'),
    args = { '-' },
    to_stdin = true,
    from_stderr = false,
    timeout = 20000,
    format = 'json',
    check_exit_code = function(code)
      return code < 1
    end,
    on_output = helpers.diagnostics.from_json({
      attributes = {
        row = 'line',
        col = 'column',
        code = 'code',
        severity = 'level',
        message = 'message',
      }
    }),
  }),
}

null_ls.register(languagetool)

-- diagnostics
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = false,
})

require('trouble').setup({
  mode = 'document_diagnostics',
  height = 5,
  padding = false,
  group = true,
  auto_open = false,
  auto_close = false,
})

-- Fix slow cursor movement on jinja2 files
vim.g.matchup_matchparen_deferred = 1

-- Autoclose and autorename HTML tags using treesitter
require('nvim-ts-autotag').setup()

-- nvim-ts-context-commentstring
vim.g.skip_ts_context_commentstring_module = true
require('ts_context_commentstring').setup()

-- Treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "bash",
    "css",
    "csv",
    "diff",
    "editorconfig",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "gpg",
    "graphql",
    "helm",
    "hjson",
    "hlsplaylist",
    "html",
    "htmldjango",
    "http",
    "ini",
    "java",
    "javascript",
    "jq",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "jsonnet",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "nginx",
    "ninja",
    "nix",
    "passwd",
    "pem",
    "perl",
    "php",
    "promql",
    "puppet",
    "python",
    "readline",
    "regex",
    "requirements",
    "ruby",
    "rust",
    "scss",
    "sql",
    "ssh_config",
    "strace",
    "svelte",
    "swift",
    "terraform",
    "tmux",
    "toml",
    "tsv",
    "tsx",
    "vim",
    "vimdoc",
    "vue",
    "xml",
    "yaml",
    "zig",
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

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- you can optionally set descriptions to the mappings (used in the desc parameter of nvim_buf_set_keymap
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
      },
      -- You can choose the select mode (default is charwise 'v')
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding xor succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      include_surrounding_whitespace = false,
    },
  },
})

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 200,
    ignore_whitespace = true,
  },
})

require('colorizer').setup()
require('guess-indent').setup()
require('hlargs').setup({
  color = '#28c9ff',
})
require('nvim-surround').setup()

require("nvim-navic").setup({
  lsp = {
    auto_attach = true,
  },
  lazy_update_context = false,
})


-- local cmp = require 'blink.cmp'
-- -- local luasnip = require 'luasnip'

-- cmp.setup {
--   -- TODO:
--   -- 'default' for mappings similar to built-in completion
--   -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
--   -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
--   -- see the "default configuration" section below for full documentation on how to define
--   -- your own keymap.
--   keymap = {
--     preset = 'super-tab',
--     -- -- Accept selection or next item is nothing is selected.
--     ['<C-space>'] = { 'select_and_accept', 'fallback' },
--     -- Accept if an item is selected.
--     ['<CR>'] = { 'accept', 'fallback' },
--     -- Accept if an item is selected, else snippet_forward, or fallback.
--     ['<C-k>'] = { 'select_prev', 'fallback' },
--     ['<C-j>'] = { 'select_next', 'fallback' },

--     ['<Up>'] = { 'select_prev', 'fallback' },
--     ['<Down>'] = { 'select_next', 'fallback' },
--   },        -- experimental auto-brackets support
--   accept = {
--     auto_brackets = { enabled = true },
--     -- expand_snippet = luasnip.lsp_expand,
--   },

--   -- experimental signature help support
--   trigger = {
--     -- completion = { show_in_snippet = false },
--     signature_help = { enabled = true },
--   },

--   fuzzy = {
--     use_typo_resistance = false,
--   },
--   sources = {
--     completion = {
--       -- Static list of providers to enable, or a function to dynamically enable/disable providers based on the context
--       enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep', 'mocword' },
--       -- Example dynamically picking providers based on the filetype and treesitter node:
--       -- enabled_providers = function(ctx)
--       --   local node = vim.treesitter.get_node()
--       --   if vim.bo.filetype == 'lua' then
--       --     return { 'lsp', 'path' }
--       --   elseif node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }), node:type())
--       --     return { 'buffer' }
--       --   else
--       --     return { 'lsp', 'path', 'snippets', 'buffer' }
--       --   end
--       -- end
--     },

--     -- Please see https://github.com/Saghen/blink.compat for using `nvim-cmp` sources
--     providers = {
--       lsp = {
--         name = 'LSP',
--         module = 'blink.cmp.sources.lsp',
--         --- *All* of the providers have the following options available
--         --- NOTE: All of these options may be functions to get dynamic behavior
--         --- See the type definitions for more information.
--         --- Check the enabled_providers config for an example
--         enabled = true, -- Whether or not to enable the provider
--         transform_items = nil, -- Function to transform the items before they're returned
--         should_show_items = true, -- Whether or not to show the items
--         max_items = nil, -- Maximum number of items to display in the menu
--         min_keyword_length = 0, -- Minimum number of characters in the keyword to trigger the provider
--         fallback_for = {}, -- If any of these providers return 0 items, it will fallback to this provider
--         score_offset = 0, -- Boost/penalize the score of the items
--         override = nil, -- Override the source's functions
--       },
--       path = {
--         name = 'Path',
--         module = 'blink.cmp.sources.path',
--         score_offset = 3,
--         opts = {
--           trailing_slash = false,
--           label_trailing_slash = true,
--           get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
--           show_hidden_files_by_default = false,
--         }
--       },
--       snippets = {
--         name = 'Snippets',
--         module = 'blink.cmp.sources.snippets',
--         score_offset = -3,
--         opts = {
--           friendly_snippets = true,
--           search_paths = { vim.fn.stdpath('config') .. '/snippets' },
--           global_snippets = { 'all' },
--           extended_filetypes = {},
--           ignored_filetypes = {},
--           get_filetype = function(context)
--             return vim.bo.filetype
--           end
--         }

--         --- Example usage for disabling the snippet provider after pressing trigger characters (i.e. ".")
--         -- enabled = function(ctx)
--         --   return ctx ~= nil and ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter
--         -- end,
--       },
--       buffer = {
--         name = 'Buffer',
--         module = 'blink.cmp.sources.buffer',
--         fallback_for = { 'lsp' },
--       },
--       ripgrep = {
--         module = "blink-ripgrep",
--         name = "ripgrep",
--         opts = {
--           prefix_min_len = 2,
--         }
--       },
--       mocword = {
--         name = 'mocword',
--         module = 'blink.compat.source',
--         opts = {
--           debug = true,
--         }
--       }
--     },
--   },
--   windows = {
--     autocomplete = {
--       auto_show = true,
--       selection = 'auto_insert',
--     },
--     documentation = {
--       auto_show = true,
--       auto_show_delay_ms = 300,
--       update_delay_ms = 50,
--     },
--     ghost_text = {
--       enabled = false,
--     },
--   },
-- }
