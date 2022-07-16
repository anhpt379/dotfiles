-- nvim-lsp-installer
local lsp_installer = require('nvim-lsp-installer')

local servers = {
  'bashls',
  'cmake',
  'cssls',
  'dockerls',
  'html',
  'jedi_language_server',
  'ansiblels',
  'jsonls',
  'puppet',
  'rust_analyzer',
  'sumneko_lua',
  'terraformls',
  'solargraph',
  'tflint',
  'vimls',
  -- 'yamlls',
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print('Installing ' .. name)
    server:install()
  end
end

lsp_installer.settings({
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗'
    }
  }
})

-- nvim-lspconfig
require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<space>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- lsp_signature
  local cfg = {
    floating_window = true,
    handler_opts = {
      border = 'single'
    }
  }
  require 'lsp_signature'.on_attach(cfg, bufnr)
  require 'lsp-status'.on_attach(client)
end

-- nvim-cmp
vim.o.pumheight = 15  -- nvim-cmp popup height

local cmp = require('cmp')

local kind_icons = {
  Text = ' ',
  Method = '',
  Function = '',
  Constructor = '',
  Field = 'ﰠ ',
  Variable = ' ',
  Class = 'ﴯ',
  Interface = '',
  Module = '',
  Property = 'ﰠ',
  Unit = '',
  Value = '',
  Enum = '',
  Keyword = '',
  Snippet = '',
  Color = '',
  File = '',
  Reference = ' ',
  Folder = '',
  EnumMember = '',
  Constant = '',
  Struct = 'פּ ',
  Event = '',
  Operator = '',
  TypeParameter = ''
}

cmp.setup({
  completion = { },
  formatting = {
    fields = { 'kind', 'abbr' },
    format = function(_, vim_item)
      vim_item.kind = kind_icons[vim_item.kind] or ''
      return vim_item
    end,
  },
  sorting = {
    comparators = {
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
    { name = 'mocword' },
    {
      name = 'rg',
      option = {
        cwd = '/home/vagrant/.config/nvim/dictionaries/hacker_news/',
        debounce = 200,
        context_before = 0,
        context_after = 0,
      }
    },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

lsp_installer.on_server_ready(function(server)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  capabilities = vim.tbl_extend(
    'keep',
    capabilities or {},
    require('lsp-status').capabilities
  )

  local opts = {
    on_attach = on_attach,
    capabilities = capabilities
  }
  server:setup(opts)
end)

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
  null_ls.builtins.diagnostics.mdl,
  null_ls.builtins.diagnostics.proselint,
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
    command = '/home/vagrant/.config/nvim/bin/remote_languagetool.py',
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

-- Treesitter
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  context_commentstring = {
    enable = true
  },
})

-- Treesitter context
require('treesitter-context').setup({
  enable = true,
  throttle = true,
  max_lines = 0,
  patterns = {
    default = {
      'class',
      'function',
      'method',
      'for',
      'while',
      'if',
      'switch',
      'case',
    },
  }
})

require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',
    delay = 200,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = true
  },
})

require'colorizer'.setup()

require('nvim-gps').setup()

require'nvim-lastplace'.setup({
  lastplace_ignore_buftype = {'quickfix', 'nofile', 'help'},
  lastplace_ignore_filetype = {'gitcommit', 'gitrebase', 'svn', 'hgcommit'},
  lastplace_open_folds = true
})
