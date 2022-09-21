local awful = require("awful")

local metaKey = "Mod4"
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

-- Can receive a single key map or a list of them
local function map_handler(keymap, handler, help)
	if keymap.keyname then
		return awful.key(keymap.modifiers, keymap.keyname, handler, help)
	else
		local result = {}
		for _, mapping in ipairs(keymap) do
			result = awful.util.table.join(result, map_handler(mapping, handler, help))
		end
		return result
	end
end

local function key(modifiers, keyname)
	return {
		modifiers = modifiers,
		keyname = keyname,
	}
end

return {
	map_handler = map_handler,
	key = key,
	numpad_keycodes = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 },
	vim = vim,
	common = common,
	altKey = altKey,
	shiftKey = shiftKey,
	ctrlKey = ctrlKey,
	metaKey = metaKey,
}
