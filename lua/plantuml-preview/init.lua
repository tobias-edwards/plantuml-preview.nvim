local M = {}

local build_config = function(opts)
	local default_config = {
		open_browser = true,
		port = 3000,
	}
	local user_config = opts or {}
	return vim.tbl_deep_extend("force", default_config, user_config)
end

local bind_commands = function()
	M.augroup = nil
	require("plantuml-preview.commands.plantuml-preview-open").setup()
	require("plantuml-preview.commands.plantuml-preview-close").setup()
	require("plantuml-preview.commands.plantuml-preview-share-image").setup({ image_type = "png" })
	require("plantuml-preview.commands.plantuml-preview-share-uml").setup()
end

M.setup = function(opts)
	M.config = build_config(opts)
	M.server = require("plantuml-preview.server")
	bind_commands()
end

return M
