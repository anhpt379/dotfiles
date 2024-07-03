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
    'cmake-language-server',
    'css-lsp',
    'dockerfile-language-server',
    'html-lsp',
    'pyright',
    'ansible-language-server',
    'nginx-language-server',
    'json-lsp',
    'rust-analyzer',
    'lua-language-server',
    'terraform-ls',
    'solargraph',
    'tflint',
    'vim-language-server',
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
  null_ls.builtins.diagnostics.shellcheck,
  null_ls.builtins.diagnostics.codespell,
  -- null_ls.builtins.diagnostics.curlylint,
  -- null_ls.builtins.diagnostics.editorconfig_checker,
  null_ls.builtins.diagnostics.eslint_d,
  -- null_ls.builtins.diagnostics.gitlint,
  null_ls.builtins.diagnostics.jsonlint,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.luacheck,
  null_ls.builtins.diagnostics.markdownlint,
  -- null_ls.builtins.diagnostics.proselint,
  null_ls.builtins.diagnostics.rubocop,
  null_ls.builtins.diagnostics.stylelint,
  -- null_ls.builtins.diagnostics.textlint,
  -- null_ls.builtins.diagnostics.write_good,
  null_ls.builtins.diagnostics.hadolint.with({ filetypes = { 'Dockerfile', 'dockerfile' } }),

  null_ls.builtins.formatting.eslint_d,
  null_ls.builtins.formatting.clang_format,
  null_ls.builtins.formatting.black,
  null_ls.builtins.formatting.fish_indent,
  null_ls.builtins.formatting.sqlformat,
  null_ls.builtins.formatting.json_tool,
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
  highlight = {
    enable = false,
  },
  yati = {
    enable = true
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
  current_line_blame_formatter_opts = {
    relative_time = true
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
