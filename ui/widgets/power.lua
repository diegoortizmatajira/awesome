local font_icons = require("ui.widgets.font-icons")
local wibox = require("wibox")
local awful = require("awful")
local clickable_container = require("ui.widgets.clickable-container")
local commands            = require("settings.commands")

local function Power(_, color)
	local custom_widget = {
		{
			font_icons.make_faicon(font_icons.power, color.hue_500),
			layout = wibox.layout.fixed.horizontal,
		},
		left = 2,
		right = 2,
		widget = wibox.container.margin,
	}
	local layoutBox = clickable_container(custom_widget)
	layoutBox:buttons(awful.util.table.join(awful.button({}, 1, function()
		awful.spawn(commands.power_options)
	end)))
	return layoutBox
end

return Power
