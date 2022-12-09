require("awful.autofocus")
require("wm.style")
require("wm.ui")
require("wm.windows")
require("wm.workspaces")
require("wm.keyboard")

-- Run garbage collector regularly to prevent memory leaks
local gears = require("gears")
gears.timer({
	timeout = 30,
	autostart = true,
	callback = function()
		collectgarbage()
	end,
})
