return {
	"coder/claudecode.nvim",
	lazy = false,
	dependencies = {},
	opts = {
		-- Configuration for claudecode main
		terminal_cmd = "claude --dangerously-skip-permissions",

		-- Configuration for the interactive terminal:
		terminal = {
			split_side = "left", -- "left" or "right"
			split_width_percentage = 0.3, -- 0.0 to 1.0
			provider = "native", -- "snacks" or "native"
			show_native_term_exit_tip = true, -- Show tip for Ctrl-\\ Ctrl-N
		},
	},
	-- The plugin will call require("claudecode").setup(opts)
	config = true,
	-- Optional: Add convenient keymaps
	keys = {
		{ "<leader>ac", "<cmd>ClaudeCode<cr>", mode = { "n", "v" }, desc = "Toggle Claude Terminal" },
		{ "<leader>ak", "<cmd>ClaudeCodeSend<cr>", mode = { "v" }, desc = "Send to Claude Code" },
		{ "<leader>ao", "<cmd>ClaudeCodeOpen<cr>", mode = { "n", "v" }, desc = "Open/Focus Claude Terminal" },
		{ "<leader>ax", "<cmd>ClaudeCodeClose<cr>", mode = { "n", "v" }, desc = "Close Claude Terminal" },
	},
}
