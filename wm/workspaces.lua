local awful = require("awful")

local function move_tag_to_screen(relative)
	local t = client.focus and client.focus.first_tag or nil
	if t == nil then
		return
	end
	awful.screen.focus_bydirection(relative, t.screen)
	t.screen = awful.screen.focused()
	awful.tag.viewonly(t)
end

local function find_empty_handler()
	for _, tag in ipairs(tags) do
		if #tag:clients() == 0 and not tag.selected then
			if MOVE_TO_CURRENT_DISPLAY and #tag.screen.tags > 1 then
				awful.tag.setscreen(screen, tag)
				tag:view_only()
				return
			else
				if tag.screen.index == screen.index then
					tag:view_only()
					return
				end
			end
		end
	end
end

local function move_to_empty_handler()
	local screen = awful.screen.focused()
	for _, tag in ipairs(tags) do
		if client.focus and #tag:clients() == 0 and not tag.selected then
			if MOVE_TO_CURRENT_DISPLAY and #tag.screen.tags > 1 then
				awful.tag.setscreen(screen, tag)
				client.focus:move_to_tag(tag)
				tag:view_only()
				return
			else
				if tag.screen.index == screen.index then
					client.focus:move_to_tag(tag)
					tag:view_only()
					return
				end
			end
		end
	end
end

return {
	move_left_handler = move_tag_to_screen("left"),
	move_right_handler = move_tag_to_screen("right"),
	move_above_handler = move_tag_to_screen("up"),
	move_below_handler = move_tag_to_screen("down"),
	find_empty_handler = find_empty_handler,
	move_to_empty_handler = move_to_empty_handler,
}
