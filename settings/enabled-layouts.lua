local awful = require("awful")
return {
	awful.layout.suit.max,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.right,
	awful.layout.suit.tile.top,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.corner.nw,
	awful.layout.suit.floating,
}
