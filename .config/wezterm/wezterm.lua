local wezterm = require("wezterm")
local config = {}

local launch_menu = {}
config.font = wezterm.font_with_fallback({ "Hack NF JBM Ligatured CCG", "Hack Nerd Font", "JetBrains Mono" })
config.font_size = 13.0

config.background = {
	{
		source = {
			File = wezterm.home_dir .. "/Downloads/nasa-Q1p7bh3SHj8-unsplash.jpg",
		},
		hsb = { brightness = 0.35 },
	},
}

-- Config WSL domains. Need to put it here so every environment knows about WSL
config.wsl_domains = {
	{
		-- The name of this specific domain.  Must be unique amonst all types
		-- of domain in the configuration file.
		name = "WSL:Ubuntu",
		-- The name of the distribution.  This identifies the WSL distribution.
		-- It must match a valid distribution from your `wsl -l -v` output in
		-- order for the domain to be useful.
		distribution = "Ubuntu",
		-- username = "hunter",

		-- The current working directory to use when spawning commands, if
		-- the SpawnCommand doesn't otherwise specify the directory.
		default_cwd = "~/",

		-- The default command to run, if the SpawnCommand doesn't otherwise
		-- override it.  Note that you may prefer to use `chsh` to set the
		-- default shell for your user inside WSL to avoid needing to
		-- specify it here
		-- default_prog = {"fish"}
	},
}

-- Setup Windows option
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- Start Ubuntu by default
	config.default_domain = "WSL:Ubuntu"
	-- Replace cmd with powershell
	config.default_prog = { "powershell.exe" }

	-- Add Powershell to launch menu
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
		domain = { DomainName = "local" },
	})
end

config.launch_menu = launch_menu

return config
