local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local mappings = require("settings.mappings")
local font_icons = require("wm.ui.widgets.font-icons")

local function button_shape(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 3)
end

local TagList = function(s, color)
	return {
		{
			font_icons.make_faicon(font_icons.tag_opening, color.hue_500),
			awful.widget.taglist({
				screen = s,
				filter = awful.widget.taglist.filter.noempty,
				buttons = awful.util.table.join(
					awful.button({}, 1, function(t)
						t:view_only()
					end),
					awful.button(mappings.prefix_workspace_moveto, 1, function(t)
						if client.focus then
							client.focus:move_to_tag(t)
							t:view_only()
						end
					end),
					awful.button({}, 3, awful.tag.viewtoggle),
					awful.button(mappings.prefix_workspace_toggle, 3, function(t)
						if client.focus then
							client.focus:toggle_tag(t)
						end
					end),
					awful.button({}, 4, function(t)
						awful.tag.viewprev(t.screen)
					end),
					awful.button({}, 5, function(t)
						awful.tag.viewnext(t.screen)
					end)
				),
				layout = {
					spacing = 10,
					spacing_widget = font_icons.make_faicon(font_icons.tag_separator, color.hue_900),
					layout = wibox.layout.fixed.horizontal,
				},
				style = {
					shape = button_shape,
				},
			}),
			font_icons.make_faicon(font_icons.tag_closing, color.hue_500),
			layout = wibox.layout.fixed.horizontal,
		},
		left = 2,
		right = 2,
		widget = wibox.container.margin,
	}
end

return TagList
