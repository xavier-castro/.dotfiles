---@diagnostic disable: undefined-global
return {
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional
			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
			-- Me
			{ "jose-elias-alvarez/typescript.nvim" },
			{ "onsails/lspkind.nvim" },
			{ "jose-elias-alvarez/null-ls.nvim" },
			{
				"jay-babu/mason-null-ls.nvim",
				event = { "BufReadPre", "BufNewFile" },
				dependencies = { "williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim" },
			},
		},
		config = function()
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					underline = true,
					update_in_insert = false,
					virtual_text = { spacing = 4, prefix = "●" },
					severity_sort = true,
				})

			-- Diagnostic symbols in the sign column (gutter)
			local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
				},
				update_in_insert = true,
				float = {
					source = "always", -- Or "if_many"
				},
			})

			local lspkind = require("lspkind")
			lspkind.init({
				mode = "symbol",
				preset = "codicons",
				symbol_map = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "ﰠ",
					Variable = "",
					Class = "ﴯ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "塞",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "פּ",
					Event = "",
					Operator = "",
					TypeParameter = "",
				},
			})
			local lsp =
				require("lsp-zero").preset({ name = "minimal", manage_nvim_cmp = false, suggest_lsp_servers = false })
			lsp.ensure_installed({ "tsserver", "eslint", "rust_analyzer" })

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

			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "buffer" },
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

			vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
			---@diagnostic disable-next-line: unused-local
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
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, opts)
				vim.keymap.set("n", "<leader>vca", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)
			end)

			lsp.setup()

			-- Call diagnostics after lspzero setup
			vim.diagnostic.config({ virtual_text = true })
			local null_ls = require("null-ls")
			local async_formatting = function(bufnr)
				bufnr = bufnr or vim.lsp.buf.format({ timeout_ms = 3000 })
			end

			null_ls.setup({
				-- add your sources / config options here
				sources = {
					require("typescript.extensions.null-ls.code-actions"),
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.formatting.stylua,
				},
				debug = false,
				on_attach = function(client, bufnr)
					if client.name == "volar" or client.name == "tsserver" then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentFormattingRangeProvider = false
					end

					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePost", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								async_formatting(bufnr)
							end,
						})
					end
				end,
			})

			-- See mason-null-ls.nvim's documentation for more details:
			-- https://github.com/jay-babu/mason-null-ls.nvim#setup
			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true, -- You can still set this to `true`
				automatic_setup = true,
			})
			-- Required when `automatic_setup` is true
			require("mason-null-ls").setup_handlers()
			require("typescript").setup({
				disable_commands = false,
				debug = false,
				go_to_source_definition = { fallback = true },
				server = {},
			})
		end,
	},
}
