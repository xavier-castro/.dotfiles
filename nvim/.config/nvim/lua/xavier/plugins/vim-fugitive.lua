return {
	"tpope/vim-fugitive",
	config = function()
		-- local Xavier_Fugitive = vim.api.nvim_create_augroup("Xavier_Fugitive", {})
		-- local autocmd = vim.api.nvim_create_autocmd
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
	end,
}
