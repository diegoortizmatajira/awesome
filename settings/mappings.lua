local key = require("utils.keyboard").key

local modKey = "Mod4"
local altKey = "Mod1"
local shiftKey = "Shift"
local ctrlKey = "Control"

local vim = {
	Up = "k",
	Down = "j",
	Left = "h",
	Right = "l",
}

local common = {
	Up = "Up",
	Down = "Down",
	Left = "Left",
	Right = "Right",
	Return = "Return",
	PageUp = "Prior",
	PageDown = "Next",
}

return {
	vim = vim,
	common = common,
	client_swap_master = key({ modKey }, "m"),
	client_full_screen = key({ modKey }, "F11"),
	client_close = key({ altKey }, "F4"),
	client_close_alt = key({ modKey }, "w"),
	client_maximize = key({ modKey }, common.PageUp),
	client_float = key({ altKey }, "f"),
	client_minimize = key({ modKey }, common.PageDown),
	client_restore_all = key({ modKey, shiftKey }, common.PageUp),
	client_minimize_all = key({ modKey, shiftKey }, common.PageDown),
	-- Prev / Next in the workspace
	client_select_prev = key({ modKey }, ","),
	client_select_next = key({ modKey }, "."),
	-- Selection by position (Global)
	client_select_below = key({ modKey }, vim.Down),
	client_select_below_alt = key({ modKey }, common.Down),
	client_select_above = key({ modKey }, vim.Up),
	client_select_above_alt = key({ modKey }, common.Up),
	client_select_left = key({ modKey }, vim.Left),
	client_select_left_alt = key({ modKey }, common.Left),
	client_select_right = key({ modKey }, vim.Right),
	client_select_right_alt = key({ modKey }, common.Right),
	client_select_urgent = key({ modKey }, "u"),
	client_switch = key({ altKey }, "Tab"),
	awesome_restart = key({ modKey, ctrlKey }, "r"),
	awesome_quit = key({ modKey, ctrlKey }, "q"),
	awesome_help = key({ modKey }, "F1"),
	system_show_desktop = key({ modKey }, "d"),
	system_next_wallpaper = key({ modKey, shiftKey }, "d"),
	workspace_previous = key({ modKey, ctrlKey }, vim.Down),
	workspace_next = key({ modKey, ctrlKey }, vim.Up),
	workspace_previous_alt = key({ modKey, ctrlKey }, common.Down),
	workspace_next_alt = key({ modKey, ctrlKey }, common.Up),
	workspace_switch = key({ modKey }, "Tab"),
	workspace_resize_layout = key({ modKey }, "r"),
	workspace_relocate = key({ modKey, shiftKey }, "r"),
	workspace_next_layout = key({ altKey }, "r"),
	workspace_prev_layout = key({ altKey, shiftKey }, "r"),
	workspace_find_empty = key({ modKey }, "n"),
	workspace_move_to_empty = key({ modKey, shiftKey }, "n"),
	app_workspace_default = key({ modKey }, common.Return),
	prefix_workspace_goto = { modKey },
	prefix_workspace_moveto = { modKey, shiftKey },
	prefix_workspace_toggle = { modKey, ctrlKey },
}
