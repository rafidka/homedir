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
  { key = "h", mods = "CMD|ALT",  action = wezterm.action{ MoveTabRelative = -1 } },
  { key = "n", mods = "CMD|ALT",  action = wezterm.action{ MoveTabRelative =  1 } },
  { key = "t", mods = "CMD",  action = wezterm.action{ SpawnTab = "CurrentPaneDomain" } },
  { key = "w", mods = "CMD",  action = wezterm.action{ CloseCurrentTab = { confirm = true } } },
  { key = "Enter", mods = "SHIFT", action = wezterm.action{ SendString="\x1b\r" }}, -- for Claude Code
  { key = "k", mods = "CMD",  action = wezterm.action.Multiple{
      wezterm.action.ClearScrollback "ScrollbackAndViewport",
    },
  },
  { key = "PageUp", mods = "NONE", action = wezterm.action.ScrollByPage(-1), },
  { key = "PageDown", mods = "NONE", action = wezterm.action.ScrollByPage(1), },
  { key = "Home", mods = "CTRL", action = wezterm.action.ScrollToTop, },
  { key = "End", mods = "CTRL", action = wezterm.action.ScrollToBottom, },
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
  { key = "PageUp", mods = "NONE", action = wezterm.action.ScrollByPage(-1), },
  { key = "PageDown", mods = "NONE", action = wezterm.action.ScrollByPage(1), },
  { key = "Home", mods = "CTRL", action = wezterm.action.ScrollToTop, },
  { key = "End", mods = "CTRL", action = wezterm.action.ScrollToBottom, },
}

config.keys = IS_MAC and mac_keys or linux_keys

-- Performance
config.front_end = "WebGpu"
config.animation_fps = 120
config.max_fps = 120

-- Window padding
config.window_padding = {
    left = 4,
    right = 4,
    top = 2,
    bottom = 2
}

-- Scroll bar
config.enable_scroll_bar = true
config.window_padding.right = "2cell" -- scroll bar fills the right padding, so we increase it have a reasonably-sized scroll bar

-- Increase scroll back history
config.scrollback_lines = 100000

local MAX_TITLE_LEN = 70  -- adjust max length here

local function get_title(tab)
  if tab.tab_title and #tab.tab_title > 0 then
    return tab.tab_title
  end
  return tab.active_pane and tab.active_pane.title or ""
end

local function clamp(s, n)
  s = s or ""
  return (#s > n) and s:sub(1, n) or s
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local short = clamp(get_title(tab), MAX_TITLE_LEN)

  -- calculate spaces so total width ~= MAX_TITLE_LEN
  local len_spaces = math.max(0, math.floor((MAX_TITLE_LEN - #short) / 2))
  local spaces = string.rep(' ', len_spaces)
  local text = spaces .. short .. spaces

  if tab.is_active then
    return {
      { Background = { Color = '0040a0' } },
      { Text = text },
    }
  end
  return {
      { Text = text }
  }
end)

return config
