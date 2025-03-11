return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
		-- "saghen/blink.cmp",
	},
	config = function()
		-- import mason and mason_lspconfig
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- NOTE: Moved from lspconfig.lua
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp") -- import cmp-nvim-lsp plugin
		local capabilities = cmp_nvim_lsp.default_capabilities() -- used to enable autocompletion (assign to every lsp server config)

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- servers for mason to install
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"gopls",
				"marksman",
				"vtsls",
			},
			-- auto install configured servers (with lspconfig)
			automatic_installation = true,
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"pylint",
				"clangd",
			},
		})

		-- NOTE: Moved from lspconfig.lua

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,

			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
							workspace = {
								-- make language server aware of run time files
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.stdpath("config") .. "/lua"] = true,
								},
							},
						},
					},
				})
			end,

			["basedpyright"] = function()
				lspconfig.basedpyright.setup({
					capabilities = capabilities,
				})
			end,

			["ts_ls"] = function()
				lspconfig.ts_ls.setup({
					capabilities = capabilities,
					root_dir = function(fname)
						-- Use tsserver unless a Deno-specific config is present
						local util = lspconfig.util
						return not util.root_pattern("deno.json", "deno.jsonc")(fname)
							and util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
					end,
					single_file_support = false,
					init_options = {
						preferences = {
							includeCompletionsWithSnippetText = true,
							includeCompletionsForImportStatements = true,
						},
					},
				})
			end,

			["vtsls"] = function()
				lspconfig.vtsls.setup({
					capabilities = capabilities,
				})
			end,
		})
	end,
}
