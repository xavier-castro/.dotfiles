return {
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({
				chat = {
					keymaps = {
						close = { "jk", "kj", "<Esc>" },
						yank_last = "<C-y>",
						scroll_up = "<C-u>",
						scroll_down = "<C-d>",
						toggle_settings = "<C-o>",
						new_session = "<C-n>",
						cycle_windows = "<Tab>",
					},
				},
				popup_input = {
					submit = "<C-s>",
				},
			})
			vim.keymap.set("n", "<leader>pp", ":ChatGPT<cr>")
			vim.keymap.set("n", "<leader>pe", ":ChatGPTEditWithInstructions<cr>")
			vim.keymap.set("v", "<leader>pf", ":ChatGPTRun fix_bugs<cr>")
			vim.keymap.set("v", "<leader>pfc", ":ChatGPTRun explain_code<cr>")
			vim.keymap.set("v", "<leader>pds", ":ChatGPTRun docstring<cr>")
			vim.keymap.set("v", "<leader>pr", ":ChatGPTRun ")
			vim.keymap.set("i", "<c-r>", "<ESC>:ChatGPTCompleteCode<cr>")
		end,
	}, -- Keybinds
}
