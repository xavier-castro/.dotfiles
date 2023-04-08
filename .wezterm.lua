local wezterm = require("wezterm")

local config = {}

config.font = wezterm.font("Berkeley Mono Trial")
config.font_size = 16
config.color_scheme = "rose-pine"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.92
config.macos_window_background_blur = 20
config.enable_tab_bar = false

return config
