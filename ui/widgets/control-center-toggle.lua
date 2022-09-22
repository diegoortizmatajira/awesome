local awful = require("awful")
local font_icons = require("ui.widgets.font-icons")
local wibox = require("wibox")
local clickable_container = require("ui.widgets.clickable-container")

local function control_center_toggle(_, color)
	local custom_widget = {
		{ font_icons.make_faicon(font_icons.notification, color.hue_500), layout = wibox.layout.fixed.horizontal },
		left = 5,
		right = 5,
		widget = wibox.container.margin,
	}
	local layoutBox = clickable_container(custom_widget)
	layoutBox:buttons(awful.util.table.join(awful.button({}, 1, function() end)))
	return layoutBox
end

return control_center_toggle
