return {
	"jose-elias-alvarez/null-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local nls = require("null-ls")
		local formatting = nls.builtins.formatting
		local diagnostics = nls.builtins.diagnostics
		local code_actions = nls.builtins.code_actions
		local lsp_formatting = function(bufnr)
			vim.lsp.buf.format({
				filter = function(client)
					return client.name == "null-ls"
				end,
				bufnr = bufnr,
			})
		end

		---@diagnostic disable-next-line: redundant-parameter
		null_ls.setup({
			sources = {
				-- MARK: Diagnostics
				diagnostics.stylelint,
				diagnostics.yamllint,
				diagnostics.jsonlint,
				-- null_ls.builtins.diagnostics.eslint_d.with({ diagnostics_format = "[eslint] #{m}\n(#{c})" }),
				-- null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.diagnostics.fish,
				-- MARK: Formatting
				formatting.stylua,
				formatting.prettierd.with({ timeout = 10000 }),
				formatting.stylelint,
				formatting.nginx_beautifier,
				formatting.shfmt,
				formatting.xmllint,
				formatting.black,
				formatting.terraform_fmt,
				formatting.yamlfmt,
				formatting.jq,
				-- code_actions.gitsigns,
				-- MARK: Code Actions
				-- code_actions.refactoring,
				code_actions.shellcheck,
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
		})

		vim.api.nvim_create_user_command("DisableLspFormatting", function()
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
		end, { nargs = 0 })
	end,
}
