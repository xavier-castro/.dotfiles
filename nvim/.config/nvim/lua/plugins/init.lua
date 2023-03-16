return {
	{
		"altermo/ultimate-autopair.nvim",
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			require("ultimate-autopair").setup({
				--Config goes here
			})
		end,
	},
	{ "nvim-tree/nvim-web-devicons" },
	{ "nvim-treesitter/nvim-treesitter-context" },
	"nvim-treesitter/playground",
	{ "folke/zen-mode.nvim" },
	{ "ThePrimeagen/refactoring.nvim" },
	{ "mbbill/undotree" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
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

	{
		"thmsmlr/gpt.nvim",
		config = function()
			require("gpt").setup({
				api_key = os.getenv("OPENAI_API_KEY"),
			})

			opts = { silent = true, noremap = true }
			vim.keymap.set("v", "<C-g>r", require("gpt").replace, {
				silent = true,
				noremap = true,
				desc = "[G]pt [R]ewrite",
			})
			vim.keymap.set("v", "<C-g>p", require("gpt").visual_prompt, {
				silent = false,
				noremap = true,
				desc = "[G]pt [P]rompt",
			})
			vim.keymap.set("n", "<C-g>p", require("gpt").prompt, {
				silent = true,
				noremap = true,
				desc = "[G]pt [P]rompt",
			})
			vim.keymap.set("n", "<C-g>c", require("gpt").cancel, {
				silent = true,
				noremap = true,
				desc = "[G]pt [C]ancel",
			})
			vim.keymap.set("i", "<C-g>p", require("gpt").prompt, {
				silent = true,
				noremap = true,
				desc = "[G]pt [P]rompt",
			})
		end,
	},
}
