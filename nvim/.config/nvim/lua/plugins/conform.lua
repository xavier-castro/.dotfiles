-- lua/plugins/conform.lua
return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>F",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				rust = { "rustfmt" },
				["*"] = { "trim_whitespace" },
			},
			-- Set up format-on-save
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters = {
				-- You can add custom formatters or override config here
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
	},
}

