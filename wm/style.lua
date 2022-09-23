local gears = require("gears")
local beautiful = require("beautiful")
local default_theme = require("settings.theme")
local function setup()
	beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

	beautiful.init(default_theme)
	print("Visual style (Theme) setup called")
end

print("Visual style (Theme) module loaded")
return {
	setup = setup,
}
