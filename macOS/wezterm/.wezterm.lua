local wezterm = require 'wezterm';
local config = {}

-- General settings ------------------------------------------------------------
config.adjust_window_size_when_changing_font_size = false
config.audible_bell = "Disabled"
config.font = wezterm.font("ComicMono NF", {weight="Light"})
config.font_size = 17.0
config.hide_tab_bar_if_only_one_tab = true
config.line_height = 1.1
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "NONE"

-- Colors ----------------------------------------------------------------------
local colors = {}

colors.background = "#141414"
colors.foreground = "#dcdfe4"

colors.cursor_bg = "#28c9ff"
colors.cursor_fg = "#ffffff"
colors.cursor_border = "#28c9ff" -- same as cursor_bg

colors.ansi = {
  "#1c1c1c", -- black
  "#e22f62", -- red
  "#5fae4d", -- green
  "#d6b152", -- yellow
  "#28c9ff", -- blue
  "#b954e1", -- magenta
  "#3cc8b4", -- cyan
  "#dcdfe4", -- white
}

colors.brights = {
  "#696969", -- black
  "#e22f62", -- red
  "#5fae4d", -- green
  "#d6b152", -- yellow
  "#28c9ff", -- blue
  "#b954e1", -- magenta
  "#3cc8b4", -- cyan
  "#ffffff", -- white
}

colors.indexed = {
  [22] = "#003010", -- darker dark green
  [28] = "#00641a", -- slightly less dark green (used for highlight over dark green)
  [52] = "#420c0c", -- darker dark red

  -- darker blacks
  [232] = "#000000", -- deep black
  [233] = "#101010", -- darker slightly-not-black (default is #121212)
}

colors.selection_bg = "#ffcc66"
colors.selection_fg = "#000000"

config.colors = colors

return config

