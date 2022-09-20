local awful = require("awful")

local function mapHandler(keymap, handler, help)
	return awful.key(keymap[1], keymap[2], handler, help)
end

local function key(modifiers, keyname)
	return { modifiers, keyname }
end

return {
	mapHandler = mapHandler,
	key = key,
	numpad_keycodes = { 87, 88, 89, 83, 84, 85, 79, 80, 81, 90 },
}
