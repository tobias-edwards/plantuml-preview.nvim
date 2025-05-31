local M = {}

M.generate_plantuml_image = function(file, callback)
	local image_dir = vim.fn.tempname()
	local filename_without_ext = vim.fs.basename(file):match("(.+)%..+$")
	local image_filename = filename_without_ext .. ".png"
	local image_file = image_dir .. "/" .. image_filename

	vim.system({ "plantuml", "-tpng", "-output", image_dir, file }, { text = true }, function(out)
		if out.code ~= 0 then
			local error_message = string.gsub(out.stderr, "\n", ". ")
			callback(error_message, nil)
		else
			callback(nil, image_file)
		end
	end)
end

local generate_encoded_url = function(file, callback)
	vim.system({ "plantuml", "-computeurl", file }, { text = true }, function(out)
		if out.code ~= 0 then
			local error_message = string.gsub(out.stderr, "\n", ". ")
			print(error_message)
			return
		end

		local encoded_url = vim.trim(out.stdout)
		callback(encoded_url)
	end)
end

M.generate_live_uml = function(file, callback)
	generate_encoded_url(file, function(encoded_url)
		local live_url = "https://www.plantuml.com/plantuml/uml/" .. encoded_url
		callback(live_url)
	end)
end

M.generate_live_image = function(file, image_type, callback)
	generate_encoded_url(file, function(encoded_url)
		local live_url = "https://www.plantuml.com/plantuml/" .. image_type .. "/" .. encoded_url
		callback(live_url)
	end)
end

return M
