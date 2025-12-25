-- UI related plugins: mini.indentscope, flash.nvim, colorizer, etc.

-- Indentscope
require('mini.indentscope').setup({
  draw = {
    delay = 10,
    animation = require('mini.indentscope').gen_animation.none(),
  },
  symbol = "▏"
})

-- Flash.nvim
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
        opts.jump_labels = not vim.fn.mode(true):find("o")
          and vim.v.count == 0
          and vim.fn.reg_executing() == ""
          and vim.fn.reg_recording() == ""
      end,
    }
  }
})

-- Colorizer
require('colorizer').setup()

-- Guess indent
require('guess-indent').setup()

-- Highlight arguments
require('hlargs').setup({
  color = '#28c9ff',
})

-- Surround
require('nvim-surround').setup()

-- Navigation breadcrumbs
require("nvim-navic").setup({
  lsp = {
    auto_attach = true,
  },
  lazy_update_context = false,
})

