local gears = require("gears")
local style = require("wm.style")
local keyboard = require("wm.keyboard")
local mouse = require("wm.mouse")
local workspaces = require("wm.workspaces")
local windows = require("wm.windows")

style.setup()
keyboard.setup()
mouse.setup()
workspaces.setup()
windows.setup()

-- Run garbage collector regularly to prevent memory leaks
gears.timer({
	timeout = 30,
	autostart = true,
	callback = function()
		collectgarbage()
	end,
})
