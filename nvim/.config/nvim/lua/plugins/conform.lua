return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			jinja = { "djlint" },
			htmldjango = { "djlint" },

			css = { "prettierd" },
			scss = { "prettierd" },
			graphql = { "prettierd" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			markdown = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },

			terraform = { "tofu_fmt", "trim_newlines", "trim_whitespace" },
			hcl = { "tofu_fmt", "trim_newlines", "trim_whitespace" },
			["terraform-vars"] = { "tofu_fmt", "trim_newlines", "trim_whitespace" },

			go = { "goimports", "gofmt" }, -- go install golang.org/x/tools/cmd/goimports@latest
			lua = { "stylua" },
			nix = { "nixpkgs_fmt" },
			python = { "ruff_format", "ruff_organize_imports" }, -- ruff_format & ruff_organize_imports  ||  black & isort
			toml = { "taplo" },
			yaml = { "prettierd", "trim_newlines" }, -- yamlfmt/yamlfix/prettierd (yamlfmt breaks yaml blocks (key: |) sometimes)

			sh = { "shfmt" },
			bash = { "shfmt" },

			templ = { "templ" },

			jsonnet = { "jsonnetfmt" },
		},
		log_level = vim.log.levels.ERROR,
		notify_on_error = true,
	}
}
