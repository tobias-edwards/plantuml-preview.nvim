local M = {}

M.setup = function()
	vim.api.nvim_create_user_command("PlantumlPreviewShareUML", function()
		local filename = vim.fn.expand("%")

		require("plantuml-preview.plantuml").generate_live_uml(
			filename,
			vim.schedule_wrap(function(url)
				require("plantuml-preview.utils").copy_to_clipboard(url)
				print(url)
				return url
			end)
		)
	end, { desc = "Generate live Plantuml URL" })
end

return M
