-- nvim-cmp configuration

local kind_icons = require('plugins.lsp').kind_icons

vim.o.pumheight = 15

local cmp = require('cmp')

cmp.setup({
  preselect = cmp.PreselectMode.None,
  completion = {},
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
      cmp.config.compare.order,
    }
  },
  snippet = {
    expand = function(args)
      -- Add your snippet engine here
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<C-y>'] = cmp.config.disable,
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
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
  })
})

