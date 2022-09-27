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

local function run_once(cmd)
	local findme = cmd
	local firstspace = cmd:find(" ")
	if firstspace then
		findme = cmd:sub(0, firstspace - 1)
	end
	awful.spawn.with_shell(string.format("pgrep -u $USER -x %s > /dev/null || (%s)", findme, cmd))
end

local function spawn_default_app_handler()
	return spawn_handler(awful.screen.focused().selected_tag.defaultApp)
end

local function spawn_wallpaper()
	run_once(commands.wallpaper)
end

return {
	awesome_restart_handler = awesome.restart,
	awesome_quit_handler = awesome.quit,
	awesome_help = hotkeys_popup.show_help,
	spawn_app_switcher_handler = spawn_handler(commands.application_switcher),
	spawn_default_app_handler = spawn_default_app_handler,
	spawn_wallpaper = spawn_wallpaper,
}
