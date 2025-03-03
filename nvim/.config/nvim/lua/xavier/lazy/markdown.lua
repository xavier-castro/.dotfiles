return {
	"MeanderingProgrammer/render-markdown.nvim",
	opts = {
		heading = {
			width = "block",
		},
		code_block = {
			background = "#000000", -- Pure black background for code blocks
			border = {
				enabled = true,
				style = "rounded",
			},
		},
	},
	config = function(_, opts)
		require("render-markdown").setup(opts)

		-- Apply highlight group overrides after setup
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				vim.api.nvim_set_hl(0, "RenderMarkdownCode", { fg = "#a8a8a8", bg = "#000000" })
				vim.api.nvim_set_hl(0, "RenderMarkdownBorder", { fg = "#585858", bg = "NONE" })
			end,
		})

		-- Apply immediately as well
		vim.api.nvim_set_hl(0, "RenderMarkdownCode", { fg = "#a8a8a8", bg = "#000000" })
		vim.api.nvim_set_hl(0, "RenderMarkdownBorder", { fg = "#585858", bg = "NONE" })
	end,
}
