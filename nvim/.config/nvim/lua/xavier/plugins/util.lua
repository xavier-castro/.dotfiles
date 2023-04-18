return { -- library used by other plugins
	{
		"nvim-lua/plenary.nvim",
		lazy = true,
	}, -- makes some plugins dot-repeatable like leap
	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	}, -- Surround
	{
		"tpope/vim-surround",
		lazy = false,
	}, -- icons
	{ "kshenoy/vim-signature", lazy = false },
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			local keymap = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			require("hop").setup()

			-- key-mappings
			keymap("", "s", "<cmd>HopChar1<CR>", opts)
			keymap("", "<leader>j", "<cmd>HopLineBC<CR>", opts)
			keymap("", "<leader>k", "<cmd>HopLineAC<CR>", opts)
			keymap("", "<leader><leader>j", "<cmd>HopWordBC<CR>", opts)
			keymap("", "<leader><leader>k", "<cmd>HopWordAC<CR>", opts)

			-- highlights
			vim.api.nvim_exec(
				[[
  highlight HopNextKey gui=bold guifg=#ff007c guibg=None
  highlight HopNextKey1 gui=bold guifg=#00dfff guibg=None
  highlight HopNextKey2 guifg=#2b8db3 guibg=None
]],
				false
			)
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
	}, -- Seen in a lot of random plugins
	{
		"MunifTanjim/nui.nvim",
		lazy = false,
	},
}
