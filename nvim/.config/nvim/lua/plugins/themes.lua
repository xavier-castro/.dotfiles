return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			variant = "main",
			colorscheme = "base",
			dim_inactive_windows = true,
			styles = {
				italic = false,
				transparency = true,
			},
		})
		vim.cmd.colorscheme("rose-pine")
	end,
}
