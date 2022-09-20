local awful = require("awful")

local function spawn(app, with_shell)
	return function()
		if with_shell == true then
			awful.util.spawn_with_shell(app)
		else
			awful.spawn(app)
		end
	end
end

local function spawn_default_app()
	return spawn(awful.screen.focused().selected_tag.defaultApp)
end

return {
	spawn = spawn,
	spawn_app_switcher = spawn("custom-alttab"),
	spawn_default_app = spawn_default_app(),
}
