return {
	-- Rose Pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})
			vim.cmd.colorscheme("rose-pine")
		end,
	},
	-- Vim Colors Plain
	{
		"andreypopp/vim-colors-plain",
		config = function()
			-- vim.cmd.colorscheme("plain")
		end,
	},
	-- No Clown Fiesta
	{
		"aktersnurra/no-clown-fiesta.nvim",
		config = function()
			require("no-clown-fiesta").setup({
				transparent = true,
				styles = {
					-- You can set any of the style values specified for `:h nvim_set_hl`
					comments = {},
					keywords = {},
					functions = {},
					variables = {},
					type = { bold = false },
					lsp = { underline = false },
				},
			})
			-- vim.cmd.colorscheme("no-clown-fiesta")
		end,
	},
	-- VSCode
	{
		"Mofiqul/vscode.nvim",
		config = function()
			require("vscode").setup({
				transparent = true,
			})
			-- vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"andreasvc/vim-256noir",
		config = function()
			-- vim.cmd.colorscheme("256_noir")
		end,
	},
	-- Gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			-- Default options:
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			-- vim.cmd("colorscheme gruvbox")
		end,
	},
}
