local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local font_icons = require("wm.ui.widgets.font-icons")
local dpi = require("beautiful").xresources.apply_dpi
local gears = require("gears")
local clickable_container = require("wm.ui.widgets.clickable-container")

local function button_shape(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 3)
end

local function Systray(s, color)
	s.systray = wibox.widget({
		base_size = 20,
		opacity = 2,
		visible = true,
		screen = "primary",
		widget = wibox.widget.systray,
	})
	local tray_container = wibox.widget({
		wibox.widget({
			wibox.widget({ s.systray, layout = wibox.layout.fixed.horizontal }),
			top = dpi(6),
			left = dpi(5),
			right = dpi(5),
			widget = wibox.container.margin,
		}),
		visible = false,
		bg = beautiful.bg_systray,
		widget = wibox.container.background,
		style = {
			shape = button_shape,
		},
	})

	local toggler_widget = font_icons.make_faicon(font_icons.expand, color.hue_400, dpi(8))

	awesome.connect_signal("widget::systray:toggle", function()
		tray_container.visible = not tray_container.visible
		if tray_container.visible then
			toggler_widget.change_icon(font_icons.collapse)
		else
			toggler_widget.change_icon(font_icons.expand)
		end
		-- end
	end)
	local layoutBox = clickable_container(toggler_widget)
	layoutBox:buttons(awful.util.table.join(awful.button({}, 1, function()
		awesome.emit_signal("widget::systray:toggle")
	end)))
	local result = wibox.widget({ tray_container, layoutBox, layout = wibox.layout.fixed.horizontal })
	return awful.widget.only_on_screen(result, "primary")
end

return Systray
