local awful = require("awful")
local gears = require("gears")

local style = require("wm.style")
local keyboard = require("wm.keyboard")
local mouse = require("wm.mouse")
local state = require("wm.state")
local layouts = require("wm.layouts")
local windows = require("wm.windows")
local workspaces = require("wm.workspaces")
local ui = require("wm.ui")
local window_rules = require("settings.window-rules")

style.setup()
keyboard.setup()
mouse.setup()
layouts.setup()
workspaces.setup()
windows.setup()
ui.setup()

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
		windows.renderClient(client, currentScreen.client_mode)
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

tag.connect_signal("property::selected", tagCallback)

tag.connect_signal("property::layout", tagCallback)

tag.connect_signal("property::selected", function(_)
	ui.updateBarsVisibility()
end)

tag.connect_signal("property::layout", workspaces.smart_layout_gaps_handler)

client.connect_signal("property::fullscreen", function(c)
	c.screen.selected_tag.fullscreenMode = c.fullscreen
	ui.updateBarsVisibility()
end)

client.connect_signal("unmanage", function(c)
	if c.fullscreen then
		c.screen.selected_tag.fullscreenMode = false
		ui.updateBarsVisibility()
	end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", clientCallback)

client.connect_signal("manage", windows.manage_signal_handler)

client.connect_signal("focus", windows.focus_signal_handler)

client.connect_signal("unfocus", windows.unfocus_signal_handler)

client.connect_signal("unmanage", clientCallback)

client.connect_signal("property::hidden", clientCallback)

client.connect_signal("property::minimized", clientCallback)

client.connect_signal("property::fullscreen", function(c)
	if c.fullscreen then
		windows.renderClient(c, "maximized")
	else
		clientCallback(c)
	end
end)

awful.rules.rules = window_rules.build(state.get_client_keys(), state.get_client_buttons())
