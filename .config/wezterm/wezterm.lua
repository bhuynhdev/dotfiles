local wezterm = require("wezterm")
local config = {}
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 13.0
config.background = {
	{
		source = {
			File = wezterm.home_dir .. "/Downloads/nasa-Q1p7bh3SHj8-unsplash.jpg",
		},
		hsb = { brightness = 0.35 },
	},
}
return config
