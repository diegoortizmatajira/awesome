local font_icons = require("ui.widgets.font-icons")
local calendar_widget = require("awesome-wm-widgets.calendar-widget.calendar")
local dpi = require("beautiful").xresources.apply_dpi
local wibox = require("wibox")
local clickable_container = require("ui.widgets.clickable-container")

local function Clock(_, color)
	-- Clock / Calendar 12AM/PM fornat
	local textclock =
		wibox.widget.textclock(string.format([[<span color='%s'>%s</span>]], color.hue_100, "%a %I:%M %p"))

	local cw = calendar_widget({ theme = "nord", placement = "top_right", radius = 8 })

	local clock_widget = wibox.widget({
		{
			font_icons.make_faicon(font_icons.icon_clock, color.hue_500),
			wibox.container.margin(textclock, dpi(3), dpi(3), dpi(3), dpi(3)),
			layout = wibox.layout.fixed.horizontal,
		},
		left = 5,
		right = 5,
		widget = wibox.container.margin,
	})
	textclock:connect_signal("button::press", function(_, _, _, button)
		if button == 1 then
			cw.toggle()
		end
	end)

	return clickable_container(clock_widget)
end

return Clock
