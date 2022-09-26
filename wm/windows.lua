local awful = require("awful")
local beautiful = require("beautiful")
local window_rules = require("settings.window-rules")

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

local function promote_to_master_handler(c)
	c:swap(awful.client.getmaster())
end

local function fullscreen_handler(c)
	c.fullscreen = not c.fullscreen
	c:raise()
end

local function close_handler(c)
	c:kill()
end

local function select_prev_handler()
	local selection = awful.client.next(-1)
	if selection then
		client.focus = selection
		selection:raise()
	end
end

local function select_next_handler()
	local selection = awful.client.next(1)
	if selection then
		client.focus = selection
		selection:raise()
	end
end

local function minimize_handler(c)
	c.minimized = true
end

local function toggle_maximize_handler(c)
	c.maximized = not c.maximized
	c:raise()
end

local function toggle_floating_handler(c)
	c.floating = not c.floating
end

local function manage_signal_handler(c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	if not awesome.startup then
		awful.client.setslave(c)
	end

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
	-- Adds a default icon to the client if it doesn't exist'
	if c and c.valid and not c.icon and beautiful.default_app_icon then
		c.icon = beautiful.default_app_icon
	end
end

local function focus_signal_handler(c)
	c.border_color = beautiful.border_focus
end

local function unfocus_signal_handler(c)
	c.border_color = beautiful.border_normal
end

local function renderClient(client, mode)
	if client.skip_decoration or (client.rendering_mode == mode) then
		return
	end
	client.rendering_mode = mode
	window_rules.reset_window_properties(client)
	if client.rendering_mode == "maximized" then
		client.border_width = 0
		client.shape = window_rules.maximized_window_shape
	elseif client.rendering_mode == "tiled" then
		client.border_width = beautiful.border_width
		client.shape = window_rules.tiled_window_shape
	end
end

local function setup() end

return {
	focus_left_handler = focus_by_direction_handler("left"),
	focus_right_handler = focus_by_direction_handler("right"),
	focus_above_handler = focus_by_direction_handler("up"),
	focus_below_handler = focus_by_direction_handler("down"),
	minimize_all_handler = toggle_all_handler(true),
	restore_all_handler = toggle_all_handler(false),
	jump_to_urgent_handler = awful.client.urgent.jumpto,
	promote_to_master_handler = promote_to_master_handler,
	fullscreen_handler = fullscreen_handler,
	close_handler = close_handler,
	select_next_handler = select_next_handler,
	select_prev_handler = select_prev_handler,
	minimize_handler = minimize_handler,
	toggle_maximize_handler = toggle_maximize_handler,
	toggle_floating_handler = toggle_floating_handler,
	manage_signal_handler = manage_signal_handler,
	focus_signal_handler = focus_signal_handler,
	unfocus_signal_handler = unfocus_signal_handler,
	renderClient = renderClient,
	setup = setup,
}
