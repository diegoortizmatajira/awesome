local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local commands = require("settings.commands")

local function spawn_handler(app, with_shell)
	return function()
		if with_shell == true then
			awful.util.spawn_with_shell(app)
		else
			awful.spawn(app)
		end
	end
end

local function spawn_default_app_handler()
	return spawn_handler(awful.screen.focused().selected_tag.defaultApp)
end

return {
	awesome_restart_handler = awesome.restart,
	awesome_quit_handler = awesome.quit,
	awesome_help = hotkeys_popup.show_help,
	spawn_app_switcher_handler = spawn_handler(commands.application_switcher),
	spawn_default_app_handler = spawn_default_app_handler,
}
