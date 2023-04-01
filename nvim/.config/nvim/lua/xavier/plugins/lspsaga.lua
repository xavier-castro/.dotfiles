return {
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				ui = {
					winblend = 10,
					border = "rounded",
					colors = {
						normal_bg = "0B2733",
					},
				},
				lightbulb = {
					enable = false,
					enable_in_insert = true,
					sign = true,
					sign_priority = 40,
					virtual_text = true,
				},
				symbol_in_winbar = {
					enable = false,
					separator = " ",
					ignore_patterns = {},
					hide_keyword = true,
					show_file = true,
					folder_level = 2,
					respect_root = false,
					color_mode = true,
				},
			})
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
			vim.keymap.set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
			vim.keymap.set("n", "gl", "<Cmd>Lspsaga show_diagnostic<CR>", opts)
			vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
			vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
			vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
			-- vim.keymap.set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
			vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
			vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
			-- vim.keymap.set("n", "<M-d>", "<cmd>Lspsaga term_toggle<cr>", opts)
			vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:q!<cr>", opts)
			vim.keymap.set("n", "<leader>nls", "<cmd>NullLsInfo<cr>", opts)

			-- code action
			local codeaction = require("lspsaga.codeaction")
			vim.keymap.set("n", "<M-.>", function()
				codeaction:code_action()
			end, { silent = true })
			vim.keymap.set("v", "<M-.>", function()
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
				codeaction:range_code_action()
			end, { silent = true })
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
}
