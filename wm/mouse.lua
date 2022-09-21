local awful = require("awful")
local keyboard = require("utils.keyboard")

local client_buttons = awful.util.table.join(
	awful.button({}, 1, function(c)
		client.focus = c
		c:raise()
	end),
	-- Left click
	awful.button({ keyboard.metaKey }, 1, awful.mouse.client.move),
	-- Right click
	awful.button({ keyboard.metaKey }, 3, awful.mouse.client.resize),
	-- Mouse Wheel up
	awful.button({ keyboard.metaKey }, 4, function()
		awful.layout.inc(1)
	end),
	-- Mouse Wheel down
	awful.button({ keyboard.metaKey }, 5, function()
		awful.layout.inc(-1)
	end)
)
local function setup()
	return {
		client_buttons = client_buttons,
	}
end

return setup
