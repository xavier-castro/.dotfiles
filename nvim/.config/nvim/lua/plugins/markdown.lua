return {
	-- Make sure to set this up properly if you have lazy=true
	"MeanderingProgrammer/render-markdown.nvim",
	enabled = true,
	dependencies = {
		"yetone/avante.nvim",
	},
	opts = function(_, opts)
		opts.file_types = opts.file_types or { "markdown", "norg", "rmd", "org" }
		vim.list_extend(opts.file_types, { "Avante", "codecompanion" })
	end,
}
