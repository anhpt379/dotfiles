-- Load all plugin configurations
local plugins = {
  'large-file',
  'ui',
  'lsp',
  'completion',
  'null-ls',
  'diagnostics',
  'treesitter',
  'git',
}

for _, plugin in ipairs(plugins) do
  local ok, err = pcall(require, 'plugins.' .. plugin)
  if not ok then
    vim.notify('Error loading ' .. plugin .. ': ' .. err, vim.log.levels.ERROR)
  end
end

