local wezterm = require("wezterm")
local config = {}

-- Generic
config.term = "wezterm"
config.audible_bell = "Disabled"
config.enable_kitty_keyboard = true
config.max_fps = 120
config.animation_fps = 60
config.front_end = "WebGpu"

-- Fonts
config.font = wezterm.font_with_fallback({
  { family = "ComicFira", weight = "Light" },
  { family = "Symbols Nerd Font Mono", scale = 0.80 },
})
config.font_size = 17.0
config.line_height = 1.1
config.freetype_load_flags = "NO_HINTING"
config.underline_position = "-0.1cell"

-- Windows
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"
config.window_padding = {
  left = "10px",
  right = "10px",
  top = 0,
  bottom = 0,
}

-- Hyperlinks
config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = [[\b([A-Z]+-\d+)\b]],
  format = "http://go/jira?searchString=$1",
})

-- Quick Select
config.quick_select_alphabet = "fjghdkslarutyioewcnvbqpxzm"
config.disable_default_quick_select_patterns = true
config.quick_select_patterns = {
  "(^| )([a-f0-9]{7,40})\\b", -- git commit hash / docker container id
  "^([a-z0-9-]+-[bcdfghjklmnpqrstvwxz0123456789]+-[bcdfghjklmnpqrstvwxz0123456789]{5})\\s", -- kubernetes pod name (https://github.com/thockin/kubernetes/blob/df7f5fca27fce282fb4815aa0464ff4797fd6bbe/staging/src/k8s.io/apimachinery/pkg/util/rand/rand.go#L81-L83)
  "\\b([A-Z]+-\\d+)\\b", -- jira ticket id
  "[a-z0-9-]+\\.[a-z0-9-.]+\\.[a-z0-9-.]+", -- server fqdn
}

-- Colors
local colors = {}
colors.background = "#161616"
colors.foreground = "#dcdfe4"
colors.cursor_bg = "#69ff94"
colors.cursor_fg = "#000000"
colors.cursor_border = "#69ff94" -- same as cursor_bg
colors.ansi = {
  "#161616", -- black
  "#e22f62", -- red
  "#5fae4d", -- green
  "#d6b152", -- yellow
  "#28c9ff", -- blue
  "#b954e1", -- magenta
  "#3cc8b4", -- cyan
  "#eeeeee", -- white
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

-- Keychain integration
function find_last_match(text, pattern)
  local last_match_line = nil
  local lines = {}

  for line in text:gmatch("[^\r\n]+") do
    table.insert(lines, line)
  end

  for line_num, line in ipairs(lines) do
    local start_pos, _ = string.find(line, pattern)
    if start_pos then
      last_match_line = line_num
    end
  end

  if last_match_line then
    return last_match_line
  else
    return nil
  end
end

wezterm.on("trigger-password-input", function(window, pane)
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

  -- macOS keychain integration
  -- Use this command to add a new password:
  --
  --   $ security add-generic-password -a <name> -s <name> -w
  --
  local keychain_password_item = nil
  local password_prompt = find_last_match(text, "^Password:")
  local passphrase_prompt = find_last_match(text, "^Enter passphrase for .*/.ssh/id_ed25519")

  if type(password_prompt) == "number" or type(passphrase_prompt) == "number" then
    if passphrase_prompt and not password_prompt then
      keychain_password_item = "passphrase"
    elseif password_prompt and not passphrase_prompt then
      keychain_password_item = "ssh"
    elseif passphrase_prompt > password_prompt then
      keychain_password_item = "passphrase"
    elseif password_prompt > passphrase_prompt then
      keychain_password_item = "ssh"
    end
  end

  if keychain_password_item then
    local _, password, _ = wezterm.run_child_process({
      "security",
      "find-generic-password",
      "-w",
      "-a",
      keychain_password_item,
    })
    window:perform_action(
      wezterm.action.Multiple({
        wezterm.action.SendString(password),
        wezterm.action.SendKey({ key = "Enter" }),
      }),
      pane
    )
  end
end)

-- Key mappings
config.bypass_mouse_reporting_modifiers = "CMD"
config.keys = {
  { key = "t", mods = "CMD", action = wezterm.action.SendString("\x1bT") },
  { key = "w", mods = "CMD", action = wezterm.action.SendString("\x1bW") },
  { key = "n", mods = "CMD", action = wezterm.action.SendString("\x1bN") },
  { key = "p", mods = "CMD", action = wezterm.action.SendString("\x1bP") },
  { key = "[", mods = "CMD", action = wezterm.action.SendString("\x1b{") },
  { key = "]", mods = "CMD", action = wezterm.action.SendString("\x1b}") },
  { key = "s", mods = "CMD", action = wezterm.action.SendString("\x1bS") },
  { key = "o", mods = "CMD", action = wezterm.action.SendString("\x1bO") },
  { key = "r", mods = "CMD", action = wezterm.action.SendString("\x1bR") },
  { key = ":", mods = "CMD|SHIFT", action = wezterm.action.SendString("\x1b;") },
  { key = "'", mods = "CMD", action = wezterm.action.SendString('\x1b"') },
  { key = "9", mods = "CMD", action = wezterm.action.SendString("\x1b(") },
  { key = "0", mods = "CMD", action = wezterm.action.SendString("\x1b)") },
  { key = "=", mods = "CMD", action = wezterm.action.SendString("\x1b+") },
  { key = "-", mods = "CMD", action = wezterm.action.SendString("\x1b_") },
  { key = "\\", mods = "CMD", action = wezterm.action.EmitEvent("trigger-password-input") },
  { key = "f", mods = "CMD", action = wezterm.action.QuickSelect },
}

return config
