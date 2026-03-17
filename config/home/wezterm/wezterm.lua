local wezterm = require("wezterm")

local function appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end

  return 'Dark'
end

local function scheme_for_appearance(current)
  if current:find('Dark') then
    return 'Gruvbox dark, hard (base16)'
  end

  return 'Gruvbox light, soft (base16)'
end

wezterm.on('format-tab-title', function(tab)
  local pane = tab.active_pane
  local proc = pane.foreground_process_name or ''
  local cmd = proc:gsub('.*[\\/]', '')

  if cmd == '' then
    cmd = pane.title or 'sh'
  end

  local label = string.format('%d: %s',
    tab.tab_index, cmd)

  return {{ Text = ' ' .. label .. ' ' }}
end)

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = scheme_for_appearance(appearance())
config.font_size = 24.0
config.font = wezterm.font({
  family = 'JetBrains Mono',
  -- disable ligatures
  harfbuzz_features = {
    'calt=0', 'clig=0', 'liga=0'
  },
})
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
-- window_decorations = "NONE"
config.native_macos_fullscreen_mode = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
