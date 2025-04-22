return {
	"ravitemer/mcphub.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
	},
	cmd = "MCPHub",          -- Lazy load by default
	event = "BufEnter",
	build = "npm install -g mcp-hub@latest",
	config = function()
		require("mcphub").setup({
			auto_approve = true,
			extensions = {

				 codecompanion = {
            -- Show the mcp tool result in the chat buffer
            show_result_in_chat = true,
            make_vars = true, -- make chat #variables from MCP server resources
            make_slash_commands = true, -- make /slash_commands from MCP server prompts
        },
			},
		})
	end,
}
