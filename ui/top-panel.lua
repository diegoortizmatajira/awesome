local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local TaskList = require("ui.widgets.task-list")
local TagList = require("ui.widgets.tag-list")
local AppsMenu = require("ui.widgets.apps-menu")
local Keyboard = require("ui.widgets.keyboard")
local Audio = require("ui.widgets.audio")
local Clock = require("ui.widgets.clock")
local ControlCenterToggle = require("ui.widgets.control-center-toggle")
local Wifi = require("ui.widgets.wifi")
local Network = require("ui.widgets.network")
local Vpn = require("ui.widgets.vpn")
local Battery = require("ui.widgets.battery")
local Bluetooth = require("ui.widgets.bluetooth")
local Power = require("ui.widgets.power")
local Systray = require("ui.widgets.systray")
local clickable_container = require("ui.widgets.clickable-container")
local mat_colors = require("utils.mat-colors")
local dpi = require("beautiful").xresources.apply_dpi

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
	local layoutBox = clickable_container(awful.widget.layoutbox(s))
	layoutBox:buttons(awful.util.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	return layoutBox
end

local TopPanel = function(s)
	local panel = wibox({
		ontop = true,
		screen = s,
		type = "dock",
		height = dpi(32),
		width = s.geometry.width,
		x = s.geometry.x,
		y = s.geometry.y,
		stretch = false,
		bg = beautiful.panel_background,
		fg = beautiful.fg_normal,
		struts = { top = dpi(32) },
	})

	panel:struts({ top = dpi(32) })

	panel:setup({
		layout = wibox.layout.align.horizontal,
		-- expand = "none",
		{
			layout = wibox.layout.fixed.horizontal,
			AppsMenu(s, mat_colors.hue_green),
			TagList(s, mat_colors.blue),
			LayoutBox(s),
		},
		{ TaskList(s), layout = wibox.layout.align.horizontal },
		{
			layout = wibox.layout.fixed.horizontal,
			Systray(s, mat_colors.green),
			Keyboard(s, mat_colors.teal),
			Audio(s, mat_colors.cyan),
			Bluetooth(s, mat_colors.hue_blue),
			Wifi(s, mat_colors.blue),
			Network(s, mat_colors.indigo),
			Vpn(s, mat_colors.hue_purple),
			Battery(s, mat_colors.purple),
			Clock(s, mat_colors.pink),
			Power(s, mat_colors.red),
			ControlCenterToggle(s, mat_colors.grey),
		},
	})

	return panel
end

return TopPanel
