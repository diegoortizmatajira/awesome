local awful = require("awful")
local top_panel = require("ui.top-panel")
local gears = require("gears")
local beautiful = require("beautiful")
local window_rules = require("settings.window-rules")
local state = require("wm.state")
local windows = require("wm.windows")
local workspaces = require("wm.workspaces")

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

local changesOnScreenCalled = false

local function changesOnScreen(currentScreen)
	local tagIsMax = currentScreen.selected_tag ~= nil and currentScreen.selected_tag.layout == awful.layout.suit.max
	local clientsToManage = {}

	for _, client in pairs(currentScreen.clients) do
		if not client.skip_decoration and not client.hidden then
			table.insert(clientsToManage, client)
		end
	end

	if tagIsMax or #clientsToManage == 1 then
		currentScreen.client_mode = "maximized"
	else
		currentScreen.client_mode = "tiled"
	end

	for _, client in pairs(clientsToManage) do
		renderClient(client, currentScreen.client_mode)
	end
	changesOnScreenCalled = false
end

local function clientCallback(client)
	if not changesOnScreenCalled then
		if not client.skip_decoration and client.screen then
			changesOnScreenCalled = true
			local screen = client.screen
			gears.timer.delayed_call(function()
				changesOnScreen(screen)
			end)
		end
	end
end

local function tagCallback(tag)
	if not changesOnScreenCalled then
		if tag.screen then
			changesOnScreenCalled = true
			local screen = tag.screen
			gears.timer.delayed_call(function()
				changesOnScreen(screen)
			end)
		end
	end
end

_G.tag.connect_signal("property::selected", tagCallback)

_G.tag.connect_signal("property::layout", tagCallback)

_G.tag.connect_signal("property::selected", function(_)
	updateBarsVisibility()
end)

_G.tag.connect_signal("property::layout", workspaces.smart_layout_gaps_handler)

_G.client.connect_signal("property::fullscreen", function(c)
	c.screen.selected_tag.fullscreenMode = c.fullscreen
	updateBarsVisibility()
end)

_G.client.connect_signal("unmanage", function(c)
	if c.fullscreen then
		c.screen.selected_tag.fullscreenMode = false
		updateBarsVisibility()
	end
end)

-- Signal function to execute when a new client appears.
_G.client.connect_signal("manage", clientCallback)

_G.client.connect_signal("manage", windows.manage_signal_handler)

_G.client.connect_signal("focus", windows.focus_signal_handler)

_G.client.connect_signal("unfocus", windows.unfocus_signal_handler)

_G.client.connect_signal("unmanage", clientCallback)

_G.client.connect_signal("property::hidden", clientCallback)

_G.client.connect_signal("property::minimized", clientCallback)

_G.client.connect_signal("property::fullscreen", function(c)
	if c.fullscreen then
		renderClient(c, "maximized")
	else
		clientCallback(c)
	end
end)

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

awful.rules.rules = window_rules.build(state.get_client_keys(), state.get_client_buttons())
print("UI Module initialized")
