return {
	{
		"jackMort/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
				keymaps = {
					close = { "<C-c>" },
					submit = "<M-r>",
					yank_last = "<C-y>",
					yank_last_code = "<C-k>",
					scroll_up = "<C-u>",
					scroll_down = "<C-d>",
					toggle_settings = "<C-o>",
					new_session = "<C-n>",
					cycle_windows = "<Tab>",
					-- in the Sessions pane
					select_session = "<Space>",
					rename_session = "r",
					delete_session = "d",
				},
			})
			vim.keymap.set("n", "<leader>cc", ":ChatGPT<cr>")
			vim.keymap.set("n", "<leader>ce", ":ChatGPTEditWithInstructions<cr>", {
				noremap = true,
			})
			vim.keymap.set("i", "<c-a>", "<ESC>:ChatGPTRunCustomCodeAction<cr>", {
				noremap = true,
			})
			vim.keymap.set("v", "<leader>ccf", ":ChatGPTRun fix_bugs<cr>")
			vim.keymap.set("v", "<leader>cce", ":ChatGPTRun explain_code<cr>")
			vim.keymap.set("v", "<leader>ccd", ":ChatGPTRun docstring<cr>")
			vim.keymap.set("v", "<leader>ccr", ":ChatGPTRun ")
			vim.keymap.set("i", "<c-r>", "<ESC>:ChatGPTCompleteCode<cr>")
		end,
	}, -- Keybinds
}
