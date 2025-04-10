return {
	{
		"Mofiqul/vscode.nvim",
		config = function()
			require("vscode").setup({
				transparent = true,
			})
			vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
			})
		end,
	},
}
