local wibox = require("wibox")
local icon_font = "Font Awesome 5 Pro Regular 12"

local function complete_widget(widget, icon_widget, color, margin)
	if margin == nil then
		margin = 3
	end
	local result = wibox.widget({ widget, left = margin, right = margin, widget = wibox.container.margin })
	result.change_icon = function(new_code)
		icon_widget.markup = string.format([[<span color='%s'>%s</span>]], color, new_code)
	end
	return result
end

local make_icon = function(code, color)
	local icon_widget = wibox.widget({
		markup = string.format([[<span color='%s'>%s</span>]], color, code),
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
	})
	local widget = wibox.widget({ icon_widget, widget = wibox.container.background })
	return complete_widget(widget, icon_widget, color)
end

local make_faicon = function(code, color, margin)
	local icon_widget = wibox.widget({
		markup = string.format([[<span color='%s'>%s</span>]], color, code),
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
		font = icon_font,
	})
	return complete_widget(icon_widget, icon_widget, color, margin)
end

return {
	tag_opening = "\u{f104}",
	tag_closing = "\u{f105}",
	tag_separator = "\u{007C}",
	icon_clock = "\u{f017}",
	icon_window = "\u{f40e}",
	icon_arrow_square_right = "\u{f33b}",
	sound_on = "\u{f028}",
	sound_off = "\u{f2e2}",
	network = "\u{f6ff}",
	wifi = "\u{f1eb}",
	keyboard = "\u{f11c}",
	vpn = "\u{f57d}",
	battery = "\u{f240}",
	bluetooth = "\u{f294}",
	power = "\u{f011}",
	search = "\u{f002}",
	home = "\u{f015}",
	windows = "\u{f17a}",
	hamburguer = "\u{f0c9}",
	collapse = "\u{f101}",
	expand = "\u{f100}",
	toggle = "\u{f3f2}",
	notification = "\u{f4a6}",
	terminal = "\u{f120}",
	browser = "\u{f267}",
	make_faicon = make_faicon,
	make_icon = make_icon,
}
