local awful = require("awful")

local function decrease_master_size_handler()
	awful.tag.incmwfact(-0.05)
end

local function increase_master_size_handler()
	awful.tag.incmwfact(0.05)
end

local function decrease_master_count_handler()
	awful.tag.incnmaster(-1, nil, true)
end

local function increase_master_count_handler()
	awful.tag.incnmaster(-1, nil, true)
end

local function decrease_column_count_handler()
	awful.tag.incncol(-1, nil, true)
end

local function increase_column_count_handler()
	awful.tag.incncol(1, nil, true)
end

local function apply_next_handler()
	awful.layout.inc(1)
end

local function apply_previous_handler()
	awful.layout.inc(-1)
end

return {
	decrease_master_size_handler = decrease_master_size_handler,
	increase_master_size_handler = increase_master_size_handler,
	decrease_master_count_handler = decrease_master_count_handler,
	increase_master_count_handler = increase_master_count_handler,
	decrease_column_count_handler = decrease_column_count_handler,
	increase_column_count_handler = increase_column_count_handler,
	apply_next_handler = apply_next_handler,
	apply_previous_handler = apply_previous_handler,
}
