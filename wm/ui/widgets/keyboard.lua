local font_icons = require("wm.ui.widgets.font-icons")
local wibox = require("wibox")
local awful = require("awful")
local clickable_container = require("wm.ui.widgets.clickable-container")
local commands = require("settings.commands")

local function Keyboard(_, color)
	local custom_widget = {
		{
			font_icons.make_faicon(font_icons.keyboard, color.hue_500),
			{
				awful.widget.watch(commands.check_keyboard_status, 15),
				fg = color.hue_100,
				widget = wibox.container.background,
			},
			layout = wibox.layout.fixed.horizontal,
		},
		left = 5,
		right = 5,
		widget = wibox.container.margin,
	}
	return clickable_container(custom_widget)
end

return Keyboard
