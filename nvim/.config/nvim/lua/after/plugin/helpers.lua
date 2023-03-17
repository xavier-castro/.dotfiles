return {
	{ "ThePrimeagen/refactoring.nvim" },
	{ "mbbill/undotree" },
	{ "folke/zen-mode.nvim" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},
}
