return {
	{
		"MunifTanjim/prettier.nvim",
		config = function()
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
							-- if `false`, skips checking `package.json` for `"prettier"` key
							check_package_json = true,
						})
					end,
					runtime_condition = function()
						-- return false to skip running prettier
						return true
					end,
					timeout = 10000,
				},
			})
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				build = function()
					---@diagnostic disable-next-line: param-type-mismatch
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jose-elias-alvarez/typescript.nvim" },
			{ "MunifTanjim/prettier.nvim" },
			{ "onsails/lspkind.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{
				"L3MON4D3/LuaSnip",
			}, -- Required
			{ "rafamadriz/friendly-snippets" },
			{ "honza/vim-snippets" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local lspkind = require("lspkind")
			local function formatForTailwindCSS(entry, vim_item)
				if vim_item.kind == "Color" and entry.completion_item.documentation then
					local _, _, r, g, b = string.find(entry.completion_item.documentation, "^rgb%((%d+), (%d+), (%d+)")
					if r then
						local color = string.format("%02x", r) .. string.format("%02x", g) .. string.format("%02x", b)
						local group = "Tw_" .. color
						if vim.fn.hlID(group) < 1 then
							vim.api.nvim_set_hl(0, group, { fg = "#" .. color })
						end
						vim_item.kind = "●"
						vim_item.kind_hl_group = group
						return vim_item
					end
				end
				vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
				return vim_item
			end

			local lsp = require("lsp-zero").preset({})
			lsp.ensure_installed({
				"tsserver",
			})

			-- (Optional) Configure lua language server for neovim
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

			lsp.set_preferences({
				suggest_lsp_servers = true,
				sign_icons = {
					error = "E",
					warn = "W",
					hint = "H",
					info = "I",
				},
			})

			lsp.on_attach(function(_, bufnr)
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "<leader>nff", "<cmd>LspZeroFormat<cr>", opts)
				vim.keymap.set("n", "<leader>nls", "<cmd>NullLsInfo<cr>", opts)
				vim.keymap.set("n", ";d", "<cmd>Telescope diagnostics<cr>", opts)
			end)

			lsp.setup()

			-- NOTE: This has to be added AFTER `lsp.setup()`
			local cmp = require("cmp")

			-- MARK: Snippets
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
				mapping = lsp.defaults.cmp_mappings({
					["<M-d>"] = cmp.mapping.scroll_docs(-4),
					["<M-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif require("luasnip").expand_or_jumpable() then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
								""
							)
						else
							fallback()
						end
					end,
					["<S-Tab>"] = function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif require("luasnip").jumpable(-1) then
							vim.fn.feedkeys(
								vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true),
								""
							)
						else
							fallback()
						end
					end,
				}),
				formatting = {
					format = lspkind.cmp_format({
						maxwidth = 50,
						before = function(entry, vim_item)
							vim_item = formatForTailwindCSS(entry, vim_item)
							return vim_item
						end,
					}),
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})

			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
			local event = "BufWritePre" -- or "BufWritePost"
			local async = event == "BufWritePost"

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.prettierd.with({
						timeout = 10000,
					}),
					null_ls.builtins.diagnostics.eslint_d.with({
						diagnostics_format = "[eslint] #{m}\n(#{c})",
					}),
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					require("typescript.extensions.null-ls.code-actions"),
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.shfmt,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.keymap.set("n", "<Leader>ff", function()
							vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
						end, { buffer = bufnr, desc = "[lsp] format" })

						-- format on save
						vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
						vim.api.nvim_create_autocmd(event, {
							buffer = bufnr,
							group = group,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr, async = async })
							end,
							desc = "[lsp] format on save",
						})
					end
					if client.supports_method("textDocument/rangeFormatting") then
						vim.keymap.set("x", "<Leader>ff", function()
							vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
						end, { buffer = bufnr, desc = "[lsp] format" })
					end
				end,
			})
			vim.diagnostic.config({
				virtual_text = true,
			})

			vim.api.nvim_create_user_command("DisableLspFormatting", function()
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = 0 })
			end, { nargs = 0 })

			vim.api.nvim_create_user_command("LuaSnipEdit", function()
				require("luasnip.loaders").edit_snippet_files({
					extend = function(ft, paths)
						if #paths == 0 then
							return {
								{
									"$CONFIG/" .. ft .. ".snippets",
									string.format("%s/%s.snippets", "../config/snippets", ft),
								},
							}
						end
						return {}
					end,
				})
			end, { nargs = 0 })
		end,
	},
}
