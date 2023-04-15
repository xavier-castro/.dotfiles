return {
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
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "jose-elias-alvarez/typescript.nvim" },
			{ "onsails/lspkind.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local lsp = require("lsp-zero").preset({})
			lsp.ensure_installed({
				"tsserver",
			})

			-- (Optional) Configure lua language server for neovim
			require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

			lsp.set_preferences({
				suggest_lsp_servers = false,
				sign_icons = {
					error = "E",
					warn = "W",
					hint = "H",
					info = "I",
				},
			})

			lsp.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }
				vim.keymap.set("n", "gd", function()
					vim.lsp.buf.definition()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_prev()
				end, opts)
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<M-.>", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "gr", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
				vim.keymap.set("n", "<leader>nls", "<cmd>NullLsInfo<cr>", opts)
				vim.keymap.set("n", "<c-e>", "<cmd>Telescope diagnostics<cr>", opts)
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
					{ name = "buffer", keyword_length = 3 },
					{ name = "luasnip", keyword_length = 2 },
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
					["<Tab>"] = nil,
					["<S-Tab>"] = nil,
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
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
			null_ls.setup({
				sources = {
					null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.code_actions.refactoring,
					require("typescript.extensions.null-ls.code-actions"),
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.shfmt,
				},
			})
			vim.diagnostic.config({
				virtual_text = true,
			})
		end,
	},
}
