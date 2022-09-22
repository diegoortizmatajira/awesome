local awful = require("awful")
local font_icons = require("ui.widgets.font-icons")
local commands = require("settings.commands")

local function AppMenu(_, color)
	local layoutBox = font_icons.clickable(font_icons.make_faicon(font_icons.home, color.hue_500, 8))
	layoutBox:buttons(awful.util.table.join(awful.button({}, 1, function()
		awful.spawn(commands.application_launcher)
	end)))
	return layoutBox
end

return AppMenu
