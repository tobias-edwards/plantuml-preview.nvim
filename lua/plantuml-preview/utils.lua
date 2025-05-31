local M = {}

M.contains_raw_pattern = function(s, pattern)
	return string.find(s, pattern, 1, true)
end

M.escape_ansi = function(str)
	-- https://stackoverflow.com/questions/48948630/lua-ansi-escapes-pattern/49209650#49209650
	return str:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")
end

M.get_cwd = function()
	return debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])")
end

M.get_plugin_dir = function()
	-- :h lua-patterns
	return debug.getinfo(1, "S").source:sub(2):match(".*/plantuml%-preview%.nvim/")
end

M.copy_to_clipboard = function(str)
	vim.api.nvim_command("let @+ = '" .. str .. "'")
end

return M
