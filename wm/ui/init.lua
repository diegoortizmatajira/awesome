local awful = require("awful")
local top_panel = require("wm.ui.top-panel")
local state = require("wm.state")

-- Hide bars when app go fullscreen
local function updateBarsVisibility()
	for s in screen do
		if s.selected_tag then
			local fullscreen = s.selected_tag.fullscreenMode
			-- Order matter here for shadow
			s.top_panel.visible = not fullscreen
		end
	end
end

local function setup()
	awful.screen.connect_for_each_screen(function(s)
		-- Create the Top panel
		s.top_panel = top_panel(s)
		-- assign the tags corresponding to current screen
		local taglist = state.get_tags()
		for _, t in ipairs(taglist) do
			if t.screen.index == s.index then
				t:view_only()
			end
		end
	end)
end

return {
	updateBarsVisibility = updateBarsVisibility,
	setup = setup,
}
