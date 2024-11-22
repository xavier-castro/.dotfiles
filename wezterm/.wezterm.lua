-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- config.font = wezterm.font("MesloLGS NF")
config.font = wezterm.font("MesloLGS NF")
config.freetype_render_target = "HorizontalLcd"
config.freetype_load_target = "Light"
config.max_fps = 144
config.enable_tab_bar = false
config.color_scheme = "Oxocarbon Dark (Gogh)"
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
config.window_background_opacity = 0.94
config.macos_window_background_blur = 40

-- and finally, return the configuration to wezterm
return config
