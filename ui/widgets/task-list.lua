local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

-- luacheck: globals client
local client = client

local tasklist_buttons = awful.util.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			-- Without this, the following
			-- :isvisible() makes no sense
			c.minimized = false
			if not c:isvisible() and c.first_tag then
				c.first_tag:view_only()
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({}, 2, function(c)
		c.kill(c)
	end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
	end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
	end)
)

local function button_shape(cr, width, height)
	gears.shape.rounded_rect(cr, width, height, 3)
end

local TaskList = function(s)
	return awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons,
		layout = wibox.layout.fixed.horizontal(),
		widget_template = {
			{
				{
					{
						{ id = "clienticon", widget = awful.widget.clienticon },
						margins = 4,
						widget = wibox.container.margin,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left = 4,
				right = 4,
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
			create_callback = function(self, c, _, _)
				self:get_children_by_id("clienticon")[1].client = c
				local _ = awful.tooltip({
					objects = { self },
					align = "bottom",
					delay_show = 0.3,
					mode = "outside",
					timer_function = function()
						return c.name
					end,
				})
			end,
		},
		style = {
			shape = button_shape,
		},
	})
end

return TaskList
