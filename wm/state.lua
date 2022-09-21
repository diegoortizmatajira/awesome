local tags
local client_keys
local client_buttons

return {
	get_tags = function()
		return tags
	end,
	set_tags = function(value)
		tags = value
	end,
	set_client_keys = function(value)
		client_keys = value
	end,
	get_client_keys = function()
		return client_keys
	end,
	set_client_buttons = function(value)
		client_buttons = value
	end,
	get_client_buttons = function()
		return client_buttons
	end,
}
