-- LSP configuration: mason, mason-lspconfig, lsp-status

-- Icons used across LSP configs
local M = {}

M.kind_icons = {
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

-- Mason setup
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Mason tool installer
require('mason-tool-installer').setup({
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
  start_delay = 3000,
})

-- Mason LSP config
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      local config = {}
      if server_name == 'lua_ls' then
        config.settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          }
        }
      elseif server_name == 'pyright' then
        config.settings = {
          python = {
            analysis = {
              diagnosticMode = 'openFilesOnly'
            }
          }
        }
      end
      vim.lsp.config(server_name, config)
      vim.lsp.enable(server_name)
    end,
  },
})

-- LSP status
local lsp_status = require('lsp-status')
lsp_status.register_progress()
lsp_status.config({
  current_function = false,
  kind_labels = M.kind_icons,
  status_symbol = '',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '',
  indicator_hint = '',
  indicator_ok = '',
})

return M

