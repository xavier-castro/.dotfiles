vim.api.nvim_set_keymap("n", "<leader>Ao", ":AiderOpen<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Am", ":AiderAddModifiedFiles<CR>", { noremap = true, silent = true })
return {
	"joshuavial/aider.nvim",
	config = function()
		require("aider").setup({
			auto_manage_context = true,
			default_bindings = true,
			debug = true,
			vim = true,
			ignore_buffers = {},

			-- only necessary if you want to change the default keybindings. <Leader>C is not a particularly good choice. It's just shown as an example.
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ac",
				":AiderOpen --no-auto-commits<CR>",
				{ noremap = true, silent = true }
			),
		})
	end,
}
