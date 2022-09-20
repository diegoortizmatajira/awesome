local awful = require("awful")
local apps = require("utils.apps")
local mapkey = require("utils.keyboard").mapHandler
local mappings = require("settings.mappings")
local windows = require("wm.windows")
local workspaces = require("wm.workspaces")

local globalKeys = awful.util.table.join(
	mapkey(mappings.awesome_restart, awesome.restart, { description = "Reload Awesome", group = "Awesome" }),
	mapkey(mappings.awesome_quit, awesome.quit, { description = "Quit Awesome", group = "Awesome" }),
	mapkey(mappings.awesome_help, hotkeys_popup.show_help, { description = "Show help", group = "Hotkeys" }),
	mapkey(
		mappings.system_show_desktop,
		windows.minimize_all_handler,
		{ description = "Show desktop", group = "Hotkeys" }
	),
	mapkey(
		mappings.client_select_below,
		windows.focus_below_handler,
		{ description = "Focus window below", group = "Windows" }
	),
	mapkey(
		mappings.client_select_above,
		windows.focus_above_handler,
		{ description = "Focus window above", group = "Windows" }
	),
	mapkey(
		mappings.client_select_right,
		windows.focus_right_handler,
		{ description = "Focus window on the right", group = "Windows" }
	),
	mapkey(
		mappings.client_select_left,
		windows.focus_left_handler,
		{ description = "Focus window on the left", group = "Windows" }
	),
	mapkey(
		mappings.client_select_below_alt,
		windows.focus_below_handler,
		{ description = "Focus window below", group = "Windows" }
	),
	mapkey(
		mappings.client_select_above_alt,
		windows.focus_above_handler,
		{ description = "Focus window above", group = "Windows" }
	),
	mapkey(
		mappings.client_select_right_alt,
		windows.focus_right_handler,
		{ description = "Focus window on the right", group = "Windows" }
	),
	mapkey(
		mappings.client_select_left_alt,
		windows.focus_left_handler,
		{ description = "Focus window on the left", group = "Windows" }
	),
	mapkey(
		mappings.client_select_urgent,
		windows.jump_to_urgent_handler,
		{ description = "Jump to urgent window", group = "Windows" }
	),
	mapkey(
		mappings.client_switch,
		apps.spawn_app_switcher,
		{ description = "Switch to other window", group = "Windows" }
	), -- Navigate workspaces
	mapkey(
		mappings.workspace_previous,
		awful.tag.viewprev,
		{ description = "Go to previous workspace", group = "Workspaces" }
	), --
	mapkey(mappings.workspace_next, awful.tag.viewnext, { description = "Go to next workspace", group = "Workspaces" }),
	mapkey(
		mappings.workspace_previous_alt,
		awful.tag.viewprev,
		{ description = "Go to previous workspace", group = "Workspaces" }
	), --
	mapkey(
		mappings.workspace_next_alt,
		awful.tag.viewnext,
		{ description = "Go to next workspace", group = "Workspaces" }
	),
	mapkey(
		mappings.workspace_switch,
		awful.tag.history.restore,
		{ description = "Go to last used workspace", group = "Workspaces" }
	),
	mapkey(
		mappings.app_workspace_default,
		apps.spawn_default_app,
		{ description = "Open default program for workspace", group = "Applications" }
	),
	-- Layout: Master Size
	mapkey(mappings.workspace_resize_layout, function()
		modalbind.grab({ keymap = layout_modify_map, name = "Modify layout", stay_in_mode = true })
	end, { description = "Resizes the current layout", group = "Modes" }), -- Layout: Move tags to different screen
	mapkey(mappings.workspace_relocate, function()
		modalbind.grab({ keymap = screen_move_map, name = "Move current tag to screen", stay_in_mode = true })
	end, { description = "Relocate current Tag", group = "Modes" }), --
	mapkey(mappings.workspace_next_layout, function()
		awful.layout.inc(1)
	end, { description = "Select next Layout", group = "Layout Distribution" }),
	mapkey(mappings.workspace_prev_layout, function()
		awful.layout.inc(-1)
	end, { description = "Select previous Layout", group = "Layout Distribution" }),
	mapkey(
		mappings.client_restore_all,
		windows.restore_all_handler,
		{ description = "Restore all windows", group = "Windows" }
	),
	mapkey(
		mappings.client_minimize_all,
		windows.minimize_all_handler,
		{ description = "Restore minimized", group = "Windows" }
	), -- Dropdown application
	-- Brightness
	-- awful.key({}, "XF86MonBrightnessUp", spawn("xbacklight -inc 10")),
	-- awful.key({}, "XF86MonBrightnessDown", spawn("xbacklight -dec 10")), -- ALSA volume control
	-- awful.key({}, "XF86AudioRaiseVolume", spawn("amixer -D pulse sset Master 5%+")),
	-- awful.key({}, "XF86AudioLowerVolume", spawn("amixer -D pulse sset Master 5%-")),
	-- awful.key({}, "XF86AudioMute", spawn("amixer -D pulse set Master 1+ toggle")),
	-- awful.key({}, "XF86AudioStop", spawn("playerctl stop")),
	-- awful.key({}, "XF86AudioPlay", spawn("playerctl play-pause")),
	-- awful.key({}, "XF86AudioPause", spawn("playerctl pause")), --
	-- awful.key({}, "XF86AudioNext", spawn("playerctl next")), --
	-- awful.key({}, "XF86AudioPrev", spawn("playerctl prev")),
	-- awful.key({}, "XF86PowerDown", spawn("custom-askpoweroptions")),
	-- awful.key({}, "XF86PowerOff", spawn("custom-askpoweroptions")), --
	mapkey(
		mappings.workspace_find_empty,
		workspaces.find_empty_handler,
		{ description = "Go to new empty workspace", group = "Workspaces" }
	),
	mapkey(
		mappings.workspace_move_to_empty,
		workspaces.move_to_empty_handler,
		{ description = "Move window to a new empty workspace", group = "Workspaces" }
	) -- Screen management
)
