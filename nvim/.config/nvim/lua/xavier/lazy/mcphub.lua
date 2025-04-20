return {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
	},
	cmd = "MCPHub", -- Lazy load by default
	event = "BufEnter",
	build = "npm install -g mcp-hub@latest",
	config = function()
		require("mcphub").setup({
			extensions = {
				avante = {
					make_slash_commands = true, -- Make /slash commands from MCP server prompts
				},
			},
		})
	end,
}
