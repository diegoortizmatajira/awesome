local font_icons = require("ui.widgets.font-icons")
local wibox = require("wibox")
local clickable_container = require("ui.widgets.clickable-container")

local function Network(_, color)
	local custom_widget = {
		{ font_icons.make_faicon(font_icons.network, color.hue_500), layout = wibox.layout.fixed.horizontal },
		left = 5,
		right = 5,
		widget = wibox.container.margin,
	}
	return clickable_container(custom_widget)
end

return Network
