require("wm.style").setup()
require("wm.keyboard").setup()
require("wm.mouse").setup()
require("wm.layouts").setup()
require("wm.workspaces").setup()
require("wm.windows").setup()
require("ui.top-panel").setup()

local gears = require("gears")
-- Run garbage collector regularly to prevent memory leaks
gears.timer({
	timeout = 30,
	autostart = true,
	callback = function()
		collectgarbage()
	end,
})
