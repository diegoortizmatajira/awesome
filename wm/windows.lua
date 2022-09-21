local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local window_rules = require("settings.window-rules")
local mouse = require("wm.mouse")
local keyboard = require("wm.keyboard")

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

local default_icon

local function _get_default_icon()
	if default_icon then
		return default_icon
	end
	local cairo = require("lgi").cairo
	local default_icon_path = "/usr/share/icons/default.svg"
	local s = gears.surface(default_icon_path)
	local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
	local cr = cairo.Context(img)
	cr:set_source_surface(s, 0, 0)
	cr:paint()
	default_icon = img._native
	return default_icon
end

local function _setup_signals()
	-- Signal function to execute when a new client appears.
	client.connect_signal("manage", function(c)
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
		if c and c.valid and not c.icon then
			c.icon = _get_default_icon()
		end
	end)

	-- Make the focused window have a glowing border
	client.connect_signal("focus", function(c)
		c.border_color = beautiful.border_focus
	end)
	client.connect_signal("unfocus", function(c)
		c.border_color = beautiful.border_normal
	end)
end

local function setup()
	_setup_signals()
	awful.rules.rules = window_rules(keyboard.client_keys, mouse.client_buttons)
end

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
	setup = setup,
}
