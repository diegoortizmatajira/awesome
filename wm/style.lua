local gtable = require("gears.table")
local beautiful = require("beautiful")
local default_theme = require("settings.theme")
local function setup()
	local final_theme = {}
	gtable.crush(final_theme, default_theme.theme)
	default_theme.awesome_overrides(final_theme)
	beautiful.init(final_theme)
end

return {
	setup = setup,
}
