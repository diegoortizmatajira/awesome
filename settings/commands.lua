return {
	application_switcher = "custom-alttab",
	application_launcher = "custom-launcher",
	terminal = "kitty",
	lock = "custom-lock",
	internet_browser = "firefox-developer-edition",
	editor = "subl",
	files = "nautilus",
	vnp_widget_command = [[bash -c "nordvpn status | grep Country | cut -d ' ' -f2- && echo ''"]],
	vpn_launcher = "custom-nordvpn-menu",
}
