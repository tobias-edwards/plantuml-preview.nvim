local api = require("plantuml-preview.api")
local core = require("plantuml-preview")

local M = {}

local update_plantuml_image = function()
	local filename = vim.fn.expand("%")
	require("plantuml-preview.plantuml").generate_plantuml_image(
		filename,
		vim.schedule_wrap(function(error, outfile)
			if error then
				api.send_error(error)
			else
				api.send_plantuml_image(outfile)
			end
		end)
	)
end

M.setup = function()
	vim.api.nvim_create_user_command("PlantumlPreviewOpen", function()
		core.augroup = vim.api.nvim_create_augroup("PlantumlPreviewGroup", {
			clear = true, -- Prevent duplicate groups on a single buffer when command ran twice
		})

		core.server.start(vim.schedule_wrap(function()
			update_plantuml_image()
		end))

		local bufnr = vim.api.nvim_get_current_buf()
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			buffer = bufnr,
			group = core.augroup,
			callback = function()
				update_plantuml_image()
			end,
			desc = "",
		})

		vim.api.nvim_create_autocmd("BufDelete", {
			buffer = 0,
			group = core.augroup,
			callback = function()
				core.server.stop()
				vim.api.nvim_del_augroup_by_id(core.augroup)
			end,
			desc = "",
		})
	end, { desc = "Preview PlantUML diagram" })
end

return M
