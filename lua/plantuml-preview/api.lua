local core = require("plantuml-preview")

local M = {}

M.send_plantuml_image = function(image_url)
	local port = core.config.port
	local url = "http://localhost:" .. port .. "/image"
	local query = { url = image_url }
	local curl = require("plenary").curl
	curl.put(url, { query = query, timeout = 1000 })
end

M.send_error = function(error)
	local port = core.config.port
	local url = "http://localhost:" .. port .. "/error"
	local query = { message = error }
	local curl = require("plenary").curl
	curl.put(url, { query = query, timeout = 1000 })
end

return M
