local wibox = require("wibox")

local function build(widget)
	local container = wibox.widget({
		widget,
		widget = wibox.container.background,
	})

	container:connect_signal("mouse::enter", function()
		container.bg = "#ffffff11"
	end)

	container:connect_signal("mouse::leave", function()
		container.bg = "#ffffff00"
	end)

	container:connect_signal("button::press", function()
		container.bg = "#ffffff22"
	end)

	container:connect_signal("button::release", function()
		container.bg = "#ffffff11"
	end)

	return container
end

return build
