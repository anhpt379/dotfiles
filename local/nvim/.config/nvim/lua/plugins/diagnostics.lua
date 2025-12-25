-- Diagnostic configuration and trouble.nvim

-- Define diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Configure diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = false,
  severity_sort = false,
})

-- Trouble setup
require("trouble").setup({
  mode = "document_diagnostics",
  height = 5,
  padding = false,
  group = true,
  auto_open = false,
  auto_close = false,
})
