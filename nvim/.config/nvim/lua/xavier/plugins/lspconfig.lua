return {
	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"nvim-lua/lsp-status.nvim",
			"pmizio/typescript-tools.nvim",
			"b0o/schemastore.nvim",
			"MunifTanjim/prettier.nvim",
			"j-hui/fidget.nvim",
			{
				"lvimuser/lsp-inlayhints.nvim",
				config = function()
					require("lsp-inlayhints").setup({})
				end,
			},
		},
		config = function()
			-- Diagnostic keymaps
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			-- LSP settings.
			--  This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(_, bufnr)
				-- NOTE: Remember that lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself
				-- many times.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
				nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
				nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
				nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
				nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
				nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
				nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				-- See `:help K` for why this keymap
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

				-- Lesser used LSP functionality
				nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
				nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
				nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
				nmap("<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, "[W]orkspace [L]ist Folders")

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					if vim.lsp.buf.format then
						vim.lsp.buf.format()
					elseif vim.lsp.buf.formatting then
						vim.lsp.buf.formatting()
					end
				end, { desc = "Format current buffer with LSP" })
			end

			--  This function gets run when an LSP connects to a particular buffer.

			-- Turn on lsp status information
			require("fidget").setup()

			-- mason-lspconfig requires that these setup functions are called in this order
			-- before setting up the servers.
			require("mason").setup()
			require("mason-lspconfig").setup()

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. They will be passed to
			--  the `settings` field of the server config. You must look up that documentation yourself.
			--
			--  If you want to override the default filetypes that your language server will attach to you can
			--  define the property 'filetypes' to the map in question.
			local servers = {
				clangd = {},
				gopls = {},
				pyright = {},
				rust_analyzer = {},
				ts_ls = {},
				html = { filetypes = { "html", "twig", "hbs" } },

				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			}

			-- Setup neovim lua configuration
			require("neodev").setup()

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

			-- Ensure the servers above are installed
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})

			if vim.g.vscode then
				return
			else
				-- vim.lsp.set_log_level("debug")
				local status, nvim_lsp = pcall(require, "lspconfig")
				if not status then
					return
				end

				local presentLspStatus, lsp_status = pcall(require, "lsp-status")
				local presentCmpNvimLsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
				local presentLspSignature, lsp_signature = pcall(require, "lsp_signature")
				local protocol = require("vim.lsp.protocol")

				-- local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
				-- local enable_format_on_save = function(_, bufnr)
				-- 	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
				-- 	vim.api.nvim_create_autocmd("BufWritePre", {
				-- 		group = augroup_format,
				-- 		buffer = bufnr,
				-- 		callback = function()
				-- 			vim.lsp.buf.format({ bufnr = bufnr })
				-- 		end,
				-- 	})
				-- end

				protocol.CompletionItemKind = {
					"", -- Text
					"", -- Method
					"", -- Function
					"", -- Constructor
					"", -- Field
					"", -- Variable
					"", -- Class
					"ﰮ", -- Interface
					"", -- Module
					"", -- Property
					"", -- Unit
					"", -- Value
					"", -- Enum
					"", -- Keyword
					"﬌", -- Snippet
					"", -- Color
					"", -- File
					"", -- Reference
					"", -- Folder
					"", -- EnumMember
					"", -- Constant
					"", -- Struct
					"", -- Event
					"ﬦ", -- Operator
					"", -- TypeParameter
				}

				-- Set up completion using nvim_cmp with LSP source
				local capabilities = require("cmp_nvim_lsp").default_capabilities()

				if presentCmpNvimLsp then
					capabilities = cmp_lsp.default_capabilities()
				else
					capabilities = vim.lsp.protocol.make_client_capabilities()
				end

				if presentLspStatus then
					lsp_status.register_progress()
					capabilities = vim.tbl_extend("keep", capabilities, lsp_status.capabilities)
				end

				nvim_lsp.jsonls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						json = {
							schemas = require("schemastore").json.schemas({
								select = {
									"package.json",
									".eslintrc",
									"GitHub Action",
									"prettierrc.json",
								},
							}),
						},
					},
				})

				-- nvim_lsp.eslint.setup({
				-- 	on_attach = on_attach,
				-- 	capabilities = capabilities,
				-- 	settings = {
				-- 		format = { enable = true },
				-- 	},
				-- })

				nvim_lsp.flow.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})

				nvim_lsp.texlab.setup({
					cmd = { "texlab" },
					filetypes = { "tex", "bib" },
					settings = {},
				})

				require("typescript-tools").setup({
					settings = {
						-- spawn additional tsserver instance to calculate diagnostics on it
						separate_diagnostic_server = true,
						-- "change"|"insert_leave" determine when the client asks the server about diagnostic
						publish_diagnostic_on = "insert_leave",
						-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
						-- "remove_unused_imports"|"organize_imports") -- or string "all"
						-- to include all supported code actions
						-- specify commands exposed as code_actions
						expose_as_code_action = {},
						-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
						-- not exists then standard path resolution strategy is applied
						tsserver_path = nil,
						-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
						-- (see 💅 `styled-components` support section)
						tsserver_plugins = {},
						-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
						-- memory limit in megabytes or "auto"(basically no limit)
						tsserver_max_memory = "auto",
						-- described below
						tsserver_format_options = {},
						tsserver_file_preferences = {},
						-- locale of all tsserver messages, supported locales you can find here:
						-- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
						tsserver_locale = "en",
						-- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
						complete_function_calls = false,
						include_completions_with_insert_text = true,
						-- CodeLens
						-- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
						-- possible values: ("off"|"all"|"implementations_only"|"references_only")
						code_lens = "off",
						-- by default code lenses are displayed on all referencable values and for some of you it can
						-- be too much this option reduce count of them by removing member references from lenses
						disable_member_code_lens = true,
						-- JSXCloseTag
						-- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
						-- that maybe have a conflict if enable this feature. )
						jsx_close_tag = {
							enable = false,
							filetypes = { "javascriptreact", "typescriptreact" },
						}
					}
				})

				nvim_lsp.sourcekit.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})

				nvim_lsp.efm.setup({
					init_options = { documentFormatting = true },
					settings = {
						rootMarkers = { ".git/" },
						languages = {
							lua = { { formatCommand = "lua-format -i", formatStdin = true } },
						},
					},
				})

				nvim_lsp.lua_ls.setup({
					capabilities = capabilities,
					on_attach = function(client, bufnr)
						on_attach(client, bufnr)
						-- enable_format_on_save(client, bufnr)
					end,
					settings = {
						Lua = {
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { "vim" },
							},

							workspace = {
								-- Make the server aware of Neovim runtime files
								library = vim.api.nvim_get_runtime_file("", true),
								checkThirdParty = false,
							},
						},
					},
				})

				nvim_lsp.tailwindcss.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})

				-- nvim_lsp.pylsp.setup({
				-- 	on_attach = on_attach,
				-- 	capabilities = capabilities,
				-- 	flags = {
				-- 		,
				-- 		allow_incremental_sync = true,
				-- 	},
				-- })

				pyright = "pyright-langserver"
				nvim_lsp.pyright.setup({
					on_attach = on_attach,
					capabilities = capabilities,
					settings = {
						python = {
							venvPath = { "~/.local/share/virtualenvs" },
						},
					},
				})

				nvim_lsp.cssls.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})

				nvim_lsp.prismals.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})

				nvim_lsp.astro.setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})

				vim.lsp.handlers["textDocument/publishDiagnostics"] =
					vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
						underline = true,
						update_in_insert = false,
						-- virtual_text = { spacing = 4, prefix = "●" },
						virtual_text = false,
						severity_sort = true,
					})

				vim.diagnostic.config({
					-- virtual_text = {
					-- 	prefix = "●",
					-- },
					virtual_text = false,
					update_in_insert = true,
					float = {
						source = "always", -- Or "if_many"
					},
				})
			end
		end,
	},
}
