local awful = require("awful")
local apps = require("utils.apps")
local mapkey = require("utils.keyboard").mapHandler
local modalbind = require("utils.modal-bind")
local mappings = require("settings.mappings")
local layouts = require("wm.layouts")
local windows = require("wm.windows")
local workspaces = require("wm.workspaces")
local keyboard = require("utils.keyboard")
local vim = mappings.vim

local screen_move_map = {
	{
		vim.Left,
		workspaces.to_left_screen_handler,
		"Move to screen on the left",
	},
	{
		vim.Right,
		workspaces.to_right_screen_handler,
		"Move to screen on the right",
	},
	{
		vim.Up,
		workspaces.to_above_screen_handler,
		"Move to screen above",
	},
	{
		vim.Down,
		workspaces.to_below_screen_handler,
		"Move to screen below",
	},
}

local layout_modify_map = {
	{
		vim.Left,
		layouts.decrease_master_size_handler,
		"Decrease Master Size",
	},
	{
		vim.Right,
		layouts.increase_master_size_handler,
		"Increase Master Size",
	},
	{
		vim.Down,
		layouts.decrease_master_count_handler,
		"Decrease Master Count",
	},
	{
		vim.Up,
		layouts.increase_master_count_handler,
		"Increase Master Count",
	},
	{
		",",
		layouts.decrease_column_count_handler,
		"Decrease Column Count",
	},
	{
		".",
		layouts.increase_column_count_handler,
		"Increase Column Count",
	},
}

local function modal_handler(options)
	return function()
		modalbind.grab(options)
	end
end

local globalKeys = awful.util.table.join(
	mapkey(
		mappings.awesome_restart,
		apps.awesome_restart_handler,
		{ description = "Reload Awesome Window Manager", group = "Awesome" }
	),
	mapkey(
		mappings.awesome_quit,
		apps.awesome_quit_handler,
		{ description = "Quit Awesome Window Manager", group = "Awesome" }
	),
	mapkey(
		mappings.awesome_help,
		apps.awesome_help,
		{ description = "Show help for Awesome Window Manager", group = "Hotkeys" }
	),
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
		apps.spawn_app_switcher_handler,
		{ description = "Switch to other window", group = "Windows" }
	),
	mapkey(
		mappings.workspace_previous,
		workspaces.select_prev_handler,
		{ description = "Go to previous workspace", group = "Workspaces" }
	),
	mapkey(
		mappings.workspace_next,
		workspaces.select_next_handler,
		{ description = "Go to next workspace", group = "Workspaces" }
	),
	mapkey(
		mappings.workspace_previous_alt,
		awful.tag.viewprev,
		{ description = "Go to previous workspace", group = "Workspaces" }
	),
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
		apps.spawn_default_app_handler,
		{ description = "Open default program for workspace", group = "Applications" }
	),
	mapkey(
		mappings.workspace_resize_layout,
		modal_handler({ keymap = layout_modify_map, name = "Modify layout", stay_in_mode = true }),
		{ description = "Resizes the current layout", group = "Modes" }
	),
	mapkey(
		mappings.workspace_relocate,
		modal_handler({ keymap = screen_move_map, name = "Move current tag to screen", stay_in_mode = true }),
		{ description = "Relocate current Tag", group = "Modes" }
	),
	mapkey(
		mappings.workspace_next_layout,
		layouts.apply_next_handler,
		{ description = "Select next Layout", group = "Layout Distribution" }
	),
	mapkey(
		mappings.workspace_prev_layout,
		layouts.apply_previous_handler,
		{ description = "Select previous Layout", group = "Layout Distribution" }
	),
	mapkey(
		mappings.client_restore_all,
		windows.restore_all_handler,
		{ description = "Restore all windows", group = "Windows" }
	),
	mapkey(
		mappings.client_minimize_all,
		windows.minimize_all_handler,
		{ description = "Restore minimized", group = "Windows" }
	),
	mapkey(
		mappings.workspace_find_empty,
		workspaces.find_empty_handler,
		{ description = "Go to new empty workspace", group = "Workspaces" }
	),
	mapkey(
		mappings.workspace_move_to_empty,
		workspaces.move_to_empty_handler,
		{ description = "Move window to a new empty workspace", group = "Workspaces" }
	)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 10 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move
	if i == 1 or i == 10 then
		descr_view = { description = "Focus workspace #", group = "Workspaces" }
		descr_toggle = { description = "Toggle tag visibility #", group = "Workspaces" }
		descr_move = { description = "Move focused window to workspace #", group = "Workspaces" }
	end
	globalKeys = awful.util.table.join(
		globalKeys, -- View tag only.
		awful.key(mappings.prefix_workspace_goto, "#" .. i + 9, workspaces.select_by_index_handler(i), descr_view), -- Toggle tag display.
		awful.key(
			mappings.prefix_workspace_goto,
			"#" .. keyboard.numpad_keycodes[i],
			workspaces.select_by_index_handler(i),
			descr_view
		), -- Toggle tag display.
		awful.key(mappings.prefix_workspace_toggle, "#" .. i + 9, workspaces.toggle_by_index_handler(i), descr_toggle), -- Move client to tag.
		awful.key(
			mappings.prefix_workspace_toggle,
			"#" .. keyboard.numpad_keycodes[i],
			workspaces.toggle_by_index_handler(i),
			descr_toggle
		), -- Move client to tag.
		awful.key(mappings.prefix_workspace_moveto, "#" .. i + 9, workspaces.assign_by_index_handler(i), descr_move), --
		awful.key(
			mappings.prefix_workspace_moveto,
			"#" .. keyboard.numpad_keycodes[i],
			workspaces.assign_by_index_handler(i),
			descr_move
		)
	)
end

return globalKeys
