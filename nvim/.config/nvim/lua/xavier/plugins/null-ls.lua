return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			{ "jose-elias-alvarez/typescript.nvim" },
		},
		config = function()
			local null_ls = require("null-ls")
			local b = null_ls.builtins

			null_ls.setup({
				sources = {
					require("typescript.extensions.null-ls.code-actions"),
					b.code_actions.refactoring,
					b.completion.luasnip,
					b.formatting.stylua,
					b.diagnostics.tsc,
					b.formatting.deno_fmt, -- will use the source for all supported file types
					b.formatting.prettierd,
					b.formatting.prismaFmt,
					b.formatting.rustywind,
					b.formatting.standardts,
					b.formatting.deno_fmt.with({
						filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
					}),
				},
			})
		end,
	},
}
