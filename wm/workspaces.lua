local awful = require("awful")
local state = require("wm.state")

local MOVE_TO_CURRENT_DISPLAY = false

local function move_to_screen_handler(relative)
	return function()
		local t = client.focus and client.focus.first_tag or nil
		if t == nil then
			return
		end
		awful.screen.focus_bydirection(relative, t.screen)
		t.screen = awful.screen.focused()
		awful.tag.viewonly(t)
	end
end

local function select_prev_handler()
	return awful.tag.viewprev
end

local function select_next_handler()
	return awful.tag.viewnext
end

local function find_empty_handler()
	local tags = state.get_tags()
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
	local tags = state.get_tags()
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

local function select_by_index_handler(i)
	return function()
		local screen = awful.screen.focused()
		local tags = state.get_tags()
		local tag = tags[i]
		if tag then
			if MOVE_TO_CURRENT_DISPLAY and #tag:clients() == 0 and not tag.selected and #tag.screen.tags > 1 then
				awful.tag.setscreen(screen, tag)
			end
			tag:view_only()
			awful.screen.focus(tag.screen)
		end
	end
end

local function toggle_by_index_handler(i)
	return function()
		local tags = state.get_tags()
		local tag = tags[i]
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end
end

local function assing_by_index_handler(i)
	return function()
		if client.focus then
			local tags = state.get_tags()
			local tag = tags[i]
			if tag then
				client.focus:move_to_tag(tag)
				tag:view_only()
			end
		end
	end
end

local function setup()
	local tags = {}
	state.set_tags(tags)
end

return {
	to_left_screen_handler = move_to_screen_handler("left"),
	to_right_screen_handler = move_to_screen_handler("right"),
	to_above_screen_handler = move_to_screen_handler("up"),
	to_below_screen_handler = move_to_screen_handler("down"),
	find_empty_handler = find_empty_handler,
	move_to_empty_handler = move_to_empty_handler,
	select_next_handler = select_next_handler,
	select_prev_handler = select_prev_handler,
	select_by_index_handler = select_by_index_handler,
	toggle_by_index_handler = toggle_by_index_handler,
	assign_by_index_handler = assing_by_index_handler,
	setup = setup,
}
