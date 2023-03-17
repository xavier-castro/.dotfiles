return {
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				panel = {
					enabled = true,
					auto_refresh = true,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-l>",
					},
				},
				suggestion = {
					enabled = true,
					auto_trigger = true,
					debounce = 75,
					keymap = {
						accept = "<M-r>",
						next = "<M->>",
						prev = "<M-<>",
						dismiss = "<C-]>",
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					hgcommit = false,
					svn = false,
					cvs = false,
					["."] = false,
				},
				copilot_node_command = "node", -- Node version must be < 18
				server_opts_overrides = {},
			})
		end,
		keys = {
			{
				"n",
				"<leader>cpat",
				":Copilot suggestion toggle_auto_trigger<cr>",
				desc = { "Toggle Auto Trigger" },
			},
			{
				"n,i",
				"<M-l>",
				":Copilot panel<cr>",
				desc = { "Toggle Copilot panel" },
			},
			event = { "VimEnter" },
		},
	},
}
