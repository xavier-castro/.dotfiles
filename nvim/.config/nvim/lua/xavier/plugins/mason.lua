return {
	{
		"williamboman/mason.nvim",
		config = function()
			local mason = require("mason")
			mason.setup({})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"jose-elias-alvarez/null-ls.nvim",
			"jose-elias-alvarez/typescript.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			require("mason-null-ls").setup({
				ensure_installed = { "tsserver", "tailwindcss", "stylua", "jq" },
				automatic_installation = true,
				automatic_setup = true, -- Recommended, but optional
			})

			---@diagnostic disable-next-line: deprecated
			require("mason-null-ls").setup_handlers({
				function(source_name, methods)
					require("mason-null-ls.automatic_setup")(source_name, methods)
				end,
			})
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					timeout_ms = 10000,
					filter = function(client)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.code_actions.refactoring,
					require("typescript.extensions.null-ls.code-actions"),
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettier.with({
						timeout = 10000,
					}),
					null_ls.builtins.formatting.rustywind,
					null_ls.builtins.formatting.rome,
					require("null-ls").builtins.formatting.shfmt,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								lsp_formatting(bufnr)
							end,
						})
					end
				end,
				vim.api.nvim_create_user_command("DisableLspFormatting", function()
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
				end, { nargs = 0 }),
			})
		end,
	},
}
