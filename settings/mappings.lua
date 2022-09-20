local key = require("utils.keyboard").key

local modKey = "Mod4"
local altKey = "Mod1"
local shiftKey = "Shift"
local ctrlKey = "Control"

return {
	client_swap_master = key({ modKey }, "m"),
	client_full_screen = key({ modKey }, "F11"),
	client_close = key({ altKey }, "F4"),
	client_close_alt = key({ modKey }, "w"),
	client_maximize = key({ modKey }, "Prior"),
	client_float = key({ altKey }, "f"),
	client_minimize = key({ modKey }, "Next"),
	client_restore_all = key({ modKey, shiftKey }, "Prior"),
	client_minimize_all = key({ modKey, shiftKey }, "Next"),
	-- Prev / Next in the workspace
	client_select_prev = key({ modKey }, ","),
	client_select_next = key({ modKey }, "."),
	-- Selection by position (Global)
	client_select_below = key({ modKey }, "j"),
	client_select_below_alt = key({ modKey }, "Down"),
	client_select_above = key({ modKey }, "k"),
	client_select_above_alt = key({ modKey }, "Up"),
	client_select_left = key({ modKey }, "h"),
	client_select_left_alt = key({ modKey }, "Left"),
	client_select_right = key({ modKey }, "l"),
	client_select_right_alt = key({ modKey }, "Right"),
	client_select_urgent = key({ modKey }, "u"),
	client_switch = key({ altKey }, "Tab"),
	awesome_restart = key({ modKey, ctrlKey }, "r"),
	awesome_quit = key({ modKey, ctrlKey }, "q"),
	awesome_help = key({ modKey }, "F1"),
	system_show_desktop = key({ modKey }, "d"),
	system_next_wallpaper = key({ modKey, shiftKey }, "d"),
	workspace_previous = key({ modKey, ctrlKey }, "j"),
	workspace_next = key({ modKey, ctrlKey }, "k"),
	workspace_previous_alt = key({ modKey, ctrlKey }, "Down"),
	workspace_next_alt = key({ modKey, ctrlKey }, "Up"),
	workspace_switch = key({ modKey }, "Tab"),
	workspace_resize_layout = key({ modKey }, "r"),
	workspace_relocate = key({ modKey, shiftKey }, "r"),
	workspace_next_layout = key({ altKey }, "r"),
	workspace_prev_layout = key({ altKey, shiftKey }, "r"),
	workspace_find_empty = key({ modKey }, "n"),
	workspace_move_to_empty = key({ modKey, shiftKey }, "n"),
	app_workspace_default = key({ modKey }, "Return"),
	prefix_workspace_goto = { modKey },
	prefix_workspace_moveto = { modKey, shiftKey },
	prefix_workspace_toggle = { modKey, ctrlKey },
}
