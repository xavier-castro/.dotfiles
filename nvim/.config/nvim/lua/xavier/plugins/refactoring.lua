---@diagnostic disable: 113
return {
	{
		"theprimeagen/refactoring.nvim",
		config = function()
			require("refactoring").setup()
			vim.keymap.set("n", "<leader>rr", vim.cmd.Refactor)
		end,
	},
}
