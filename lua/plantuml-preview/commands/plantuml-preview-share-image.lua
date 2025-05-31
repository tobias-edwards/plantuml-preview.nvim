local M = {}

local validate_image_type = function(image_type)
	if image_type ~= "png" and image_type ~= "svg" and image_type ~= "txt" then
		print("Invalid image_type for PlantumlPreviewShareImage: must be 'png', 'svg' or 'txt'. Falling back to 'png'.")
		return "png" -- Fallback to 'png'
	end
	return image_type
end

M.setup = function(opts)
	local setup_image_type = validate_image_type(opts.image_type)

	vim.api.nvim_create_user_command("PlantumlPreviewShareImage", function(opts)
		local image_type_arg = opts.args
		local image_type
		if image_type_arg and image_type_arg ~= "" then
			image_type = validate_image_type(image_type_arg)
		else
			image_type = setup_image_type
		end

		local filename = vim.fn.expand("%")

		require("plantuml-preview.plantuml").generate_live_image(
			filename,
			image_type,
			vim.schedule_wrap(function(url)
				require("plantuml-preview.utils").copy_to_clipboard(url)
				print(url)
				return url
			end)
		)
	end, { desc = "Generate live Plantuml image", nargs = "?" })
end

return M
