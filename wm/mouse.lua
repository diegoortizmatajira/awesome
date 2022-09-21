local awful = require("awful")
local input = require("utils.input")
local state = require("wm.state")

local client_buttons = awful.util.table.join(
	awful.button({}, 1, function(c)
		client.focus = c
		c:raise()
	end),
	-- Left click
	awful.button({ input.metaKey }, 1, awful.mouse.client.move),
	-- Right click
	awful.button({ input.metaKey }, 3, awful.mouse.client.resize),
	-- Mouse Wheel up
	awful.button({ input.metaKey }, 4, function()
		awful.layout.inc(1)
	end),
	-- Mouse Wheel down
	awful.button({ input.metaKey }, 5, function()
		awful.layout.inc(-1)
	end)
)
local function setup()
	state.set_client_buttons(client_buttons)
end

return {
	setup = setup,
}
