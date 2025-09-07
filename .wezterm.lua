local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- OS flags
local triple = wezterm.target_triple or ""
local IS_MAC   = triple:find("darwin") ~= nil
local IS_LINUX = triple:find("linux") ~= nil

-- Window geometry
config.initial_cols = 140
config.initial_rows = 40

-- Fonts (portable fallbacks)
local emoji_font = IS_MAC and "Apple Color Emoji" or "Noto Color Emoji"
config.font = wezterm.font_with_fallback({
  { family = "JetBrains Mono NL", weight = "Bold" },
  "JetBrains Mono",
  "Cascadia Code",
  "FiraCode Nerd Font",
  "Symbols Nerd Font",
  emoji_font,
})
config.font_size = IS_MAC and 14.0 or 11.0

-- Colors
config.color_scheme = 'Builtin Tango Dark'

-- Alt/Option behavior: keep composing on mac, disable on Linux so Alt-* bindings work
config.send_composed_key_when_left_alt_is_pressed  = IS_MAC
config.send_composed_key_when_right_alt_is_pressed = IS_MAC

-- Keymaps
local mac_keys = {
  { key = "h", mods = "CMD",  action = wezterm.action{ ActivateTabRelative = -1 } },
  { key = "n", mods = "CMD",  action = wezterm.action{ ActivateTabRelative =  1 } },
  { key = "t", mods = "CMD",  action = wezterm.action{ SpawnTab = "CurrentPaneDomain" } },
  { key = "w", mods = "CMD",  action = wezterm.action{ CloseCurrentTab = { confirm = true } } },
  { key = "k", mods = "CMD",  action = wezterm.action.Multiple{
      wezterm.action.ClearScrollback "ScrollbackAndViewport",
    },
  },
}

-- Linux-specific per your request:
-- - Alt-h / Alt-n: move tabs
-- - Ctrl-t: new tab
-- - No close-tab binding
-- - Alt-k: clear scrollback+viewport
local linux_keys = {
  { key = "h", mods = "ALT",  action = wezterm.action{ ActivateTabRelative = -1 } },
  { key = "n", mods = "ALT",  action = wezterm.action{ ActivateTabRelative =  1 } },
  { key = "t", mods = "ALT",  action = wezterm.action{ SpawnTab = "CurrentPaneDomain" } },
  { key = "k", mods = "ALT",  action = wezterm.action.Multiple{
      wezterm.action.ClearScrollback "ScrollbackAndViewport",
    },
  },
}

config.keys = IS_MAC and mac_keys or linux_keys

-- Performance
config.front_end = "WebGpu"
config.animation_fps = 120
config.max_fps = 120

-- Window padding
config.window_padding = { left = 4, right = 4, top = 2, bottom = 2 }

-- Scroll bar
config.enable_scroll_bar = true

return config
