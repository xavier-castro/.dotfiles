return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports" }, -- "gofumpt"
				bash = { "beautysh" },
				sh = { "beautysh" },
				fish = { "beautysh" },
				zsh = { "beautysh" },
				javascript = { "prettierd", "prettier" },
				typescript = { "prettierd", "eslint_d" },
				javascriptreact = { "prettierd", "eslint_d" },
				typescriptreact = { "prettierd", "eslint_d" },
				astro = { "prettierd", "prettier" },
				css = { "prettierd", "prettier" },
				html = { "prettierd", "prettier" },
				json = { "prettierd" },
				jsonc = { "prettierd" },
				yaml = { "prettierd", "prettier" },
				markdown = { "prettierd" },
				graphql = { "prettierd", "prettier" },
			},
		})
	end,
}
