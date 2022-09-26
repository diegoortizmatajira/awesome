pcall(require, "luarocks.loader")

require('awful.autofocus')
require("wm")

local gears = require("gears")
-- Run garbage collector regularly to prevent memory leaks
gears.timer({
	timeout = 30,
	autostart = true,
	callback = function()
		collectgarbage()
	end,
})
