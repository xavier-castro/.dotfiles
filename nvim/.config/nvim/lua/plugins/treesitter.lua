return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = { { "windwp/nvim-ts-autotag" } },
		config = function()
			local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
			parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }

			local ts = require("nvim-treesitter.configs")
			ts.setup({
				highlight = {
					enable = true,
					disable = {},
				},
				indent = {
					enable = true,
					disable = {},
				},
				ensure_installed = {
					"markdown",
					"markdown_inline",
					"tsx",
					"toml",
					"fish",
					"php",
					"json",
					"yaml",
					"swift",
					"css",
					"html",
					"lua",
				},
				autotag = {
					enable = true,
				},
			})
		end,
	},
}
