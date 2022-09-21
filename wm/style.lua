local beautiful = require("beautiful")

local function setup()
	beautiful.init(require("settings.theme"))
end

return {
	setup = setup,
}
