local filesystem = require("gears.filesystem")
local gears = require("gears")
local dpi = require("beautiful").xresources.apply_dpi
local mat_colors = require("utils.mat-colors")

local theme = {}
local mono_font = "Jetbrains Mono Bold 9"
-- local serif_font = 'SF Pro Display 9'
local serif_font = mono_font
-- local symbol_font = 'Font Awesome 5 Pro Regular 9'
local symbol_font = mono_font
theme.font = serif_font

-- Colors Pallets

-- Primary
theme.primary = mat_colors.hue_green

-- Accent
theme.accent = mat_colors.orange

-- Background
theme.background = mat_colors.background
theme.panel_background = theme.background.hue_800 .. "AA"

theme.icons = filesystem.get_configuration_dir() .. "/icons"

local transparent = "#00000000"

local awesome_overrides = function(new_theme)
	new_theme.wallpaper = "#e0e0e0"
	new_theme.font = serif_font
	new_theme.title_font = serif_font

	new_theme.fg_normal = "#ffffffde"

	new_theme.fg_focus = "#e4e4e4"
	new_theme.fg_urgent = "#CC9393"
	new_theme.bat_fg_critical = "#232323"

	new_theme.bg_normal = new_theme.panel_background
	new_theme.bg_focus = "#5a5a5a"
	new_theme.bg_urgent = "#3F3F3F"
	new_theme.bg_systray = new_theme.background.hue_800

	-- Borders

	new_theme.border_width = dpi(1)
	new_theme.border_focus = new_theme.primary.hue_300 .. "44"
	new_theme.border_normal = new_theme.background.hue_700 .. "AA"
	new_theme.border_marked = "#CC9393"

	-- Menu

	new_theme.menu_height = dpi(16)
	new_theme.menu_width = dpi(160)

	-- Tooltips
	new_theme.tooltip_bg = "#232323"
	-- theme.tooltip_border_color = '#232323'
	new_theme.tooltip_border_width = 0
	new_theme.tooltip_shape = function(cr, w, h)
		gears.shape.rounded_rect(cr, w, h, dpi(3))
	end

	-- Layout

	new_theme.layout_max = new_theme.icons .. "layouts/max.png"
	new_theme.layout_tile = new_theme.icons .. "layouts/tile.png"
	new_theme.layout_tileleft = new_theme.icons .. "layouts/tileleft.png"
	new_theme.layout_tiletop = new_theme.icons .. "layouts/tiletop.png"
	new_theme.layout_tilebottom = new_theme.icons .. "layouts/tilebottom.png"
	new_theme.layout_floating = new_theme.icons .. "layouts/floating.png"
	new_theme.layout_cornernw = new_theme.icons .. "layouts/cornernw.png"

	-- Taglist

	new_theme.taglist_font = symbol_font
	new_theme.taglist_bg_empty = transparent
	new_theme.taglist_bg_occupied = transparent
	new_theme.taglist_bg_urgent = {
		type = "linear",
		from = { 0, 0 },
		to = { 0, dpi(40) },
		stops = {
			{ 0, new_theme.accent.hue_600 },
			{ 0.07, new_theme.accent.hue_600 },
			{ 0.08, new_theme.background.hue_600 .. "66" },
			{ 0.95, new_theme.accent.hue_300 .. "FF" },
		},
	}
	new_theme.taglist_bg_focus = {
		type = "linear",
		from = { 0, 0 },
		to = { 0, dpi(40) },
		stops = {
			{ 0, new_theme.accent.hue_600 },
			{ 0.07, new_theme.accent.hue_600 },
			{ 0.08, new_theme.background.hue_600 .. "66" },
			{ 0.95, new_theme.background.hue_600 .. "FF" },
		},
	}
	-- Tasklist

	new_theme.tasklist_font = mono_font
	new_theme.tasklist_bg_normal = transparent
	new_theme.tasklist_bg_focus = {
		type = "linear",
		from = { 0, 0 },
		to = { 0, dpi(40) },
		stops = {
			{ 0, new_theme.primary.hue_400 },
			{ 0.07, new_theme.primary.hue_400 },
			{ 0.08, new_theme.background.hue_600 .. "66" },
			{ 0.95, new_theme.background.hue_600 .. "FF" },
		},
	}
	new_theme.tasklist_bg_urgent = new_theme.primary.hue_800
	new_theme.tasklist_fg_focus = "#DDDDDD"
	new_theme.tasklist_fg_urgent = new_theme.fg_normal
	new_theme.tasklist_fg_normal = "#AAAAAA"

	new_theme.icon_theme = "Papirus-Dark"
end
return {
	theme = theme,
	awesome_overrides = awesome_overrides,
}
