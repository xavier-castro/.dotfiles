local prettier = require("prettier")

prettier.setup({
	bin = "prettierd", -- or `'prettierd'` (v0.23.3+)
	filetypes = {
		"css",
		"graphql",
		"html",
		"javascript",
		"javascriptreact",
		"json",
		"less",
		"markdown",
		"scss",
		"typescript",
		"typescriptreact",
		"yaml",
	},
	["null-ls"] = {
		condition = function()
			return prettier.config_exists({
				check_package_json = true,
			})
		end,
		runtime_condition = function()
			return true
		end,
		timeout = 10000,
	},
})
