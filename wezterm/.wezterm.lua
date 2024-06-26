local wezterm = require("wezterm")

-- Pull in the wezterm API
-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font = wezterm.font("ComicShannsMono Nerd Font")

config.hide_tab_bar_if_only_one_tab = true
-- For example, changing the color scheme:
config.color_scheme = "OneDark (base16)"
config.font_size = 12.0

-- and finally, return the configuration to wezterm
return config
