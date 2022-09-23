local function log_print(msg, table_value)
	print("-- DEBUG ----")
	print(msg)
	print("- - - - - - -")
	if table_value then
		for index, data in ipairs(table_value) do
			print(index)

			for key, value in pairs(data) do
				print("\t", key, value)
			end
		end
	else
		print("Value is null")
	end
	print("------------")
end

return {
	log_print = log_print,
}
