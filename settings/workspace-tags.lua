local awful = require("awful")
local commands = require("settings.commands")
return {
	{
		name = 1, --
		icon = "\u{f104}",
		defaultApp = commands.internet_browser,
		screen = 1,
		layout = awful.layout.suit.max,
	},
	{
		name = 2,
		icon = "\u{f104}",
		defaultApp = commands.application_launcher,
		screen = 1,
		layout = awful.layout.suit.max,
	},
	{
		name = 3,
		icon = "\u{f104}",
		defaultApp = commands.application_launcher,
		screen = 1,
		layout = awful.layout.suit.max,
	},
	{
		name = 4, --
		icon = "",
		defaultApp = commands.application_launcher,
		screen = 1,
		layout = awful.layout.suit.max,
	},
	{
		name = 5, --
		icon = "",
		defaultApp = commands.application_launcher,
		screen = 1,
		layout = awful.layout.suit.max,
	},
	{
		name = 6, --
		icon = "",
		defaultApp = commands.application_launcher,
		screen = 2,
		layout = awful.layout.suit.max,
	},
	{
		name = 7,
		icon = "\u{f104}",
		defaultApp = commands.application_launcher,
		screen = 2,
		layout = awful.layout.suit.max,
	},
	{
		name = 8,
		icon = "\u{f104}",
		defaultApp = commands.application_launcher,
		screen = 2,
		layout = awful.layout.suit.max,
	},
	{
		name = 9,
		icon = "\u{f104}",
		defaultApp = commands.application_launcher,
		screen = 2,
		layout = awful.layout.suit.tile.left,
	},
	{
		name = 0, --
		icon = "\u{f104}",
		defaultApp = commands.terminal,
		screen = 1,
		layout = awful.layout.suit.max,
	},
	{
		name = "Last",
		icon = "",
		defaultApp = commands.application_launcher,
		screen = 3,
		layout = awful.layout.suit.max,
	},
}
