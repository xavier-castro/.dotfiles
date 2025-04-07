return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = false },
			---@type lspconfig.options
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = function()
			local keys = require("lazyvim.plugins.lsp.keymaps").get()
			vim.list_extend(keys, {
				{
					"gd",
					function()
						-- DO NOT RESUSE WINDOW
						require("telescope.builtin").lsp_definitions({ reuse_win = false })
					end,
					desc = "Goto Definition",
					has = "definition",
				},
			})
		end,
	},
}
