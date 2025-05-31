local core = require("plantuml-preview")

local M = {}

local process = nil

function M.stop()
	if process == nil then -- Server not running
		return 0
	else
		local kill_signal = "sigint" -- :h uv_signal_t
		process:kill(kill_signal)
		process = nil
		return 0
	end
end

function M.start(callback)
	local server_dir = require("plantuml-preview.utils").get_plugin_dir() .. "server"
	local port = core.config.port
	local open_browser = core.config.open_browser and "true" or "false"

	process = vim.system({
		"deno",
		"run",
		"start",
		"--port=" .. port,
		"--open-browser=" .. open_browser,
	}, {
		cwd = server_dir,
		detach = false,
		stdout = function(err, out)
			local server_ready_message = "CONNECTED\n"
			if err == nil and out == server_ready_message then
				callback()
			end
		end,
		text = true,
	}, function(out)
		local contains_raw_pattern = require("plantuml-preview.utils").contains_raw_pattern
		if out.code == 1 and contains_raw_pattern(out.stderr, "AddrInUse: Address already in use") then
			print("PlantumlPreview is already running at http://localhost:" .. port)
			callback()
		end
	end)
end

return M
