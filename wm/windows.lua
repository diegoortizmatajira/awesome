local awful = require("awful")

local function focus_by_direction_handler(direction)
	return function()
		awful.client.focus.global_bydirection(direction)
	end
end

local function toggle_all_handler(minimized)
	return function()
		for _, c in ipairs(mouse.screen.selected_tag:clients()) do
			c.minimized = minimized
		end
	end
end

return {
	focus_left_handler = focus_by_direction_handler("left"),
	focus_right_handler = focus_by_direction_handler("right"),
	focus_above_handler = focus_by_direction_handler("up"),
	focus_below_handler = focus_by_direction_handler("down"),
	minimize_all_handler = toggle_all_handler(true),
	restore_all_handler = toggle_all_handler(false),
	jump_to_urgent_handler = awful.client.urgent.jumpto,
}
