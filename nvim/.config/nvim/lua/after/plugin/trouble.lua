---@diagnostic disable: undefined-global
return {
	{
		"folke/trouble.nvim",
		config = function()
			vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
		end,
	},
}
