local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local act = wezterm.action
config.keys = {
  { key = 'd', mods = 'CMD|SHIFT', action = act.SplitPane { direction = 'Right' } },
  { key = 'd', mods = 'CMD', action = act.SplitPane { direction = 'Down' } },
  { key = 'w', mods = 'CMD|SHIFT', action = act.CloseCurrentPane { confirm = false } },
  { key = 'RightArrow', mods = 'CMD', action = act.ActivatePaneDirection 'Right' },
  { key = 'LeftArrow', mods = 'CMD', action = act.ActivatePaneDirection 'Left' },
  { key = 'DownArrow', mods = 'CMD', action = act.ActivatePaneDirection 'Down' },
  { key = 'UpArrow', mods = 'CMD', action = act.ActivatePaneDirection 'Up' },
}
config.color_scheme = "rose-pine-moon"
config.max_fps = 120
config.initial_cols = 120
config.initial_rows = 28
config.font_size = 12
config.font = wezterm.font('SF Mono')
-- Set transparency globally
config.window_background_opacity = 0.4

-- macOS-specific blur effect
if wezterm.target_triple:find("darwin") then
  config.macos_window_background_blur = 50
  config.font_size = 14.0
  -- Removed: config.window_frame.font_size = 13.0
end

return config