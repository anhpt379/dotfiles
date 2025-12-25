-- null-ls configuration for linting and formatting

local null_ls = require('null-ls')
local helpers = require('null-ls.helpers')

-- Define sources
local sources = {
  -- Code actions
  null_ls.builtins.code_actions.gitsigns,

  -- Diagnostics
  null_ls.builtins.diagnostics.ansiblelint,
  null_ls.builtins.diagnostics.vint,
  null_ls.builtins.diagnostics.codespell,
  null_ls.builtins.diagnostics.gitlint,
  null_ls.builtins.diagnostics.fish,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.diagnostics.markdownlint,
  null_ls.builtins.diagnostics.rubocop,
  null_ls.builtins.diagnostics.stylelint,
  null_ls.builtins.diagnostics.hadolint.with({
    filetypes = { 'Dockerfile', 'dockerfile' }
  }),

  -- Formatting
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

-- Custom languagetool integration
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

