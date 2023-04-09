return {
	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({
				icons = false,
			})
			vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", {
				silent = true,
				noremap = true,
			})
			vim.keymap.set("n", "<leader>xt", "<cmd>TodoTrouble<cr>", {
				silent = true,
				noremap = true,
			})
		end,
	},
}
