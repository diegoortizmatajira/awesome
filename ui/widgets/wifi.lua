local font_icons = require("ui.widgets.font-icons")

local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local watch = require("awful.widget.watch")
local clickable_container = require("ui.widgets.clickable-container")

local wifiarc_widget = {}

local function worker(user_args)
	local args = user_args or {}

	local font = args.font or "Font Awesome 5 Pro Regular 6"
	local arc_thickness = args.arc_thickness or 2
	local size = args.size or 18
	local timeout = args.timeout or 10
	local show_notification_mode = args.show_notification_mode or "on_hover" -- on_hover / on_click

	local main_color = args.main_color or beautiful.fg_color
	local bg_color = args.bg_color or "#ffffff11"
	local icon_color = args.icon_color or beautiful.fg_color

	local text = wibox.widget({
		font = font,
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
		markup = string.format([[<span color='%s'>%s</span>]], icon_color, font_icons.wifi),
	})

	local text_with_background = wibox.container.background(text)

	wifiarc_widget = wibox.widget({
		text_with_background,
		max_value = 100,
		rounded_edge = true,
		thickness = arc_thickness,
		start_angle = 4.71238898, -- 2pi*3/4
		forced_height = size,
		forced_width = size,
		bg = bg_color,
		paddings = 2,
		widget = wibox.container.arcchart,
	})

	local function update_widget(widget, stdout)
		local signal_strenght = 100
		if stdout ~= nil then
			signal_strenght = tonumber(stdout)
		end

		widget.value = signal_strenght

		text_with_background.bg = "#00000000"
		text_with_background.fg = main_color

		widget.colors = { main_color }
	end

	watch([[awk 'NR==3 {printf "%3.0f" ,($3/70)*100}' /proc/net/wireless]], timeout, update_widget, wifiarc_widget)

	-- Popup with battery info
	local notification
	local function show_wifi_status()
		awful.spawn.easy_async([[iwgetid -r]], function(stdout, _, _, _)
			naughty.destroy(notification)
			notification =
				naughty.notify({ text = "SSID: " .. stdout, title = "Wifi status", timeout = 5, width = 200 })
		end)
	end

	if show_notification_mode == "on_hover" then
		wifiarc_widget:connect_signal("mouse::enter", function()
			show_wifi_status()
		end)
		wifiarc_widget:connect_signal("mouse::leave", function()
			naughty.destroy(notification)
		end)
	elseif show_notification_mode == "on_click" then
		wifiarc_widget:connect_signal("button::press", function(_, _, _, button)
			if button == 1 then
				show_wifi_status()
			end
		end)
	end

	return wifiarc_widget
end

local function internal_arc_widget()
	return setmetatable(wifiarc_widget, {
		__call = function(_, ...)
			return worker(...)
		end,
	})
end

local function Wifi(_, color)
	local custom_widget = {
		{
			internal_arc_widget()({
				arc_thickness = 2,
				main_color = color.hue_500,
				bg_color = color.hue_900,
				icon_color = color.hue_100,
			}),
			layout = wibox.layout.fixed.horizontal,
		},
		left = 5,
		right = 5,
		widget = wibox.container.margin,
	}
	return clickable_container(custom_widget)
end

return Wifi
