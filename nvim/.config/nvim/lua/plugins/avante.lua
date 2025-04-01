return {
	{
		"yetone/avante.nvim",
		lazy = true,
		event = "BufRead",
		build = "make",
		dependencies = {
			{
				"MeanderingProgrammer/render-markdown.nvim",
				ft = { "Avante" },
			},
		},
	},
	{
		"stevearc/dressing.nvim",
		lazy = true,
		opts = {
			input = { enabled = false },
			select = { enabled = false },
		},
	},
}
