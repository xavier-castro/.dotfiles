return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
			})
			-- vim.cmd.colorscheme("rose-pine")
		end,
	},
	{ "andreypopp/vim-colors-plain", config=function ()
	   vim.cmd.colorscheme("plain")
	end },
}
