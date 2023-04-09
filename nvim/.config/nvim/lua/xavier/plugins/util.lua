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
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			local hop = require("hop")
			local directions = require("hop.hint").HintDirection
			vim.keymap.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true })
			vim.keymap.set("", "t", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
			end, { remap = true })
			vim.keymap.set("", "T", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
			end, { remap = true })
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
