local wezterm = require 'wezterm';
local config = {}

config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.color_scheme = '3024 (dark) (terminal.sexy)'
config.font = wezterm.font("ComicMono NF", {weight="Light"})
config.font_size = 17.0
config.hide_tab_bar_if_only_one_tab = true
config.line_height = 1.1
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE"

return config

