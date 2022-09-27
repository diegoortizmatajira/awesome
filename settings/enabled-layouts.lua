local awful = require("awful")
return {
	awful.layout.suit.max,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.right,
	awful.layout.suit.tile.top,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.corner.nw,
	awful.layout.suit.floating,
	-- awful.layout.suit.fair,
	-- awful.layout.suit.fair.horizontal,
	-- awful.layout.suit.spiral,
	-- awful.layout.suit.spiral.dwindle,
	-- awful.layout.suit.max.fullscreen,
	-- awful.layout.suit.magnifier,
}
