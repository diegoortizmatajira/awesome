local awful = require("awful")
local commands = require("settings.commands")
return {
	{ name = 1, defaultApp = commands.internet_browser, screen = 1, layout = awful.layout.suit.max },
	{ name = 2, defaultApp = commands.application_launcher, screen = 1, layout = awful.layout.suit.max },
	{ name = 3, defaultApp = commands.application_launcher, screen = 1, layout = awful.layout.suit.max },
	{ name = 4, defaultApp = commands.application_launcher, screen = 1, layout = awful.layout.suit.max },
	{ name = 5, defaultApp = commands.application_launcher, screen = 1, layout = awful.layout.suit.max },
	{ name = 6, defaultApp = commands.application_launcher, screen = 2, layout = awful.layout.suit.max },
	{ name = 7, defaultApp = commands.application_launcher, screen = 2, layout = awful.layout.suit.max },
	{ name = 8, defaultApp = commands.application_launcher, screen = 2, layout = awful.layout.suit.max },
	{ name = 9, defaultApp = commands.application_launcher, screen = 2, layout = awful.layout.suit.tile.left },
	{ name = 0, defaultApp = commands.terminal, screen = 1, layout = awful.layout.suit.max },
	{ name = "Last", defaultApp = commands.application_launcher, screen = 3, layout = awful.layout.suit.max },
}
