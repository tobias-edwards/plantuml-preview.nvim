local health = vim.health or require("health")
local start = health.start or health.report_start
local ok = health.ok or health.report_ok
local warn = health.warn or health.report_warn
local error = health.error or health.report_error

local M = {}

local dependencies = {
	{
		type = "binary",
		name = "deno",
		optional = false,
	},
	{
		type = "binary",
		name = "plantuml",
		optional = false,
	},
	{
		type = "plugin",
		name = "plenary",
		optional = false,
	},
}

local binary_installed = function(dep)
	local found = vim.fn.executable(dep.name) == 1
	return found
end

local lualib_installed = function(dep)
	local res, _ = pcall(require, dep.name)
	return res
end

local check_installed = {
	binary = binary_installed,
	plugin = lualib_installed,
}

M.check = function()
	start("Checking for dependencies")
	for _, dep in ipairs(dependencies) do
		if check_installed[dep.type](dep) then
			ok(dep.name .. " installed.")
		else
			if dep.optional then
				warn("(Optional) " .. dep.name .. " not installed. " .. dep.reason)
			else
				error(dep.name .. " not installed. ")
			end
		end
	end
end

return M
