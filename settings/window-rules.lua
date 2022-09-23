local awful = require("awful")
local gears = require("gears")

local function maximized_window_shape()
	return function(cr, w, h)
		gears.shape.rectangle(cr, w, h)
	end
end

local function tiled_window_shape()
	return function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 8)
	end
end

local function floating_window_shape()
	return function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, 8)
	end
end

local floating_properties = {
	placement = awful.placement.centered,
	floating = true,
	drawBackdrop = true,
	shape = floating_window_shape,
	skip_decoration = true,
}

local function reset_window_properties(properties)
	properties.floating = false
	properties.maximized = false
	properties.above = false
	properties.below = false
	properties.ontop = false
	properties.sticky = false
	properties.maximized_horizontal = false
	properties.maximized_vertical = false
	return properties
end

local function build(client_keys, client_buttons)
	return {
		-- All clients will match this rule.
		{
			rule = {},
			properties = reset_window_properties({
				focus = awful.client.focus.filter,
				raise = true,
				keys = client_keys,
				buttons = client_buttons,
				screen = awful.screen.preferred,
				placement = awful.placement.no_offscreen,
			}),
		},
		{
			rule = { name = "Picture-in-Picture" },
			properties = {
				floating = true,
				shape = floating_window_shape,
				skip_decoration = true,
			},
		},
		{
			rule = { class = "zoom", name = "Settings" },
			properties = floating_properties,
		},
		{
			rule = { class = "zoom", name = "Select.*" },
			properties = floating_properties,
		},
		{
			rule = { class = "jetbrains-.*", name = "Welcome to JetBrains Rider" },
			properties = floating_properties,
		},
		{
			rule = { class = "jetbrains-.*", name = "win0" },
			properties = floating_properties,
		},
		{
			rule_any = { type = { "dialog" }, class = { "Wicd-client.py", "calendar.google.com" }, role = { "Popup" } },
			properties = floating_properties,
		},
		{
			rule = { class = "Xfce4-display-settings" },
			properties = floating_properties,
		},
		{
			rule_any = { type = { "desktop" } },
			properties = { hidden = true, sticky = true, border_width = 0, skip_taskbar = true, keys = {} },
		},
	}
end

return {
	build = build,
	maximized_window_shape = maximized_window_shape,
	tiled_window_shape = tiled_window_shape,
	reset_window_properties = reset_window_properties,
}
