return {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
	},
	enabled = true,
	cmd = "MCPHub", -- Lazy load by default
	event = "BufEnter",
	build = "npm install -g mcp-hub@latest",
	config = function()
		require("mcphub").setup({
			auto_approve = true,
			extensions = {
				codecompanion = {
					-- Show the mcp tool result in the chat buffer
					show_result_in_chat = true,
					make_vars = true,      -- make chat #variables from MCP server resources
					make_slash_commands = true, -- make /slash_commands from MCP server prompts
				},
			},
			port = 3008, -- Port for the mcp-hub Express server
			-- CRITICAL: Must be an absolute path
			config = vim.fn.expand("~/.config/mcphub/servers.json"),
			log = {
				level = vim.log.levels.WARN, -- Adjust verbosity (DEBUG, INFO, WARN, ERROR)
				to_file = true,          -- Log to ~/.local/state/nvim/mcphub.log
			},
			on_ready = function()
				vim.notify("MCP Hub backend server is initialized and ready.", vim.log.levels.INFO)
			end
		})
	end,
}
