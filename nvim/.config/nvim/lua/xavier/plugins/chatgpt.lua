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
				welcome_message = WELCOME_MESSAGE,
				loading_text = "loading",
				question_sign = "", -- you can use emoji if you want e.g. 🙂
				answer_sign = "ﮧ", -- 🤖
				max_line_length = 120,
				yank_register = "+",
				chat_layout = {
					relative = "editor",
					position = "50%",
					size = {
						height = "80%",
						width = "80%",
					},
				},
				settings_window = {
					border = {
						style = "rounded",
						text = {
							top = " Settings ",
						},
					},
				},
				chat_window = {
					filetype = "chatgpt",
					border = {
						highlight = "FloatBorder",
						style = "rounded",
						text = {
							top = " ChatGPT ",
						},
					},
				},
				chat_input = {
					prompt = "  ",
					border = {
						highlight = "FloatBorder",
						style = "rounded",
						text = {
							top_align = "center",
							top = " Prompt ",
						},
					},
				},
				openai_params = {
					model = "gpt-3.5-turbo",
					frequency_penalty = 0,
					presence_penalty = 0,
					max_tokens = 300,
					temperature = 0,
					top_p = 1,
					n = 1,
				},
				openai_edit_params = {
					model = "code-davinci-edit-001",
					temperature = 0,
					top_p = 1,
					n = 1,
				},
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
				predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
				actions_paths = { "~/.config/nvim/custom_actions.json" },
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
