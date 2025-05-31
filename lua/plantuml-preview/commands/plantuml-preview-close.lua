local core = require("plantuml-preview")

local M = {}

M.setup = function()
	vim.api.nvim_create_user_command("PlantumlPreviewClose", function()
		local ok, _ = pcall(vim.api.nvim_del_augroup_by_id, core.augroup)
		core.server.stop()

		if not ok then
			print("PlantumlPreview already closed")
		else
			print("PlantumlPreview stopped")
		end
	end, { desc = "Stop PlantumlPreview" })
end

return M
