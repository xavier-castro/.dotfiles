return {
	{
		"echasnovski/mini.nvim",
		dependencies = { "https://github.com/rafamadriz/friendly-snippets" },
		config = function()
			require("mini.basics").setup()
			require("mini.ai").setup()
			require("mini.align").setup()
			require("mini.bracketed").setup()
			require("mini.bufremove").setup()

			-- MARK: UI START
			require("mini.colors").setup()
			require("mini.indentscope").setup()
			require("mini.hipatterns").setup()
			require("mini.cursorword").setup()
			-- MARK: UI END

			-- MARK: TEXT START
			require("mini.comment").setup()
			require("mini.surround").setup()
			require("mini.pairs").setup()
		end,
	},
}
