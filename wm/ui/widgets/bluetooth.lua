local font_icons = require("wm.ui.widgets.font-icons")
local wibox = require("wibox")
local awful = require("awful")
local commands = require("settings.commands")
local clickable_container = require("wm.ui.widgets.clickable-container")

local function bluetooth(_, color)
	local custom_widget = wibox.widget({
		{
			font_icons.make_faicon(font_icons.bluetooth, color.hue_500, 5),
			layout = wibox.layout.fixed.horizontal,
		},
		left = 5,
		right = 5,
		widget = wibox.container.margin,
	})
	local layoutBox = clickable_container(custom_widget)
	layoutBox:buttons(awful.util.table.join(awful.button({}, 1, function()
		awful.spawn(commands.bluetooth_options)
	end)))
	return layoutBox
end

return bluetooth
