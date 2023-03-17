return {
	{
		"zbirenbaum/copilot.lua",
		event = "VimEnter", -- On First notice it is already going
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

			vim.keymap.set("n", "<leader>cp", ":Copilot suggestion toggle_auto_trigger<cr>")
			vim.keymap.set("n", "<leader>cc", ":ChatGPT<cr>")
			vim.keymap.set("n", "<leader>cm", ":ChatGPTActAs<cr>")
		end,
	},
}
