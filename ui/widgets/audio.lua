local wibox = require("wibox")
local volume_widget = require("awesome-wm-widgets.volume-widget.volume")
local clickable_container = require("ui.widgets.clickable-container")

local function Audio(_, color)
	local custom_widget = {
		{
			volume_widget({
				widget_type = "arc",
				main_color = color.hue_500,
				bg_color = color.hue_900,
				mute_color = color.hue_50,
			}),
			layout = wibox.layout.fixed.horizontal,
		},
		left = 5,
		right = 5,
		widget = wibox.container.margin,
	}
	return clickable_container(custom_widget)
end

return Audio
