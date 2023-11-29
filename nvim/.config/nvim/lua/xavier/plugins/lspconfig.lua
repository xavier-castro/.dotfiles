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
			"jose-elias-alvarez/typescript.nvim",
			"b0o/schemastore.nvim",
			"MunifTanjim/prettier.nvim",
		},
		config = function()
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
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				-- rust_analyzer = {},
				-- tsserver = {},
				-- html = { filetypes = { 'html', 'twig', 'hbs'} },

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

				-- Use an on_attach function to only map the following keys
				-- after the language server attaches to the current buffer
				local on_attach = function(client, bufnr)
					-- Enable completion triggered by <c-x><c-o>
					-- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
					-- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
					if presentLspSignature then
						lsp_signature.on_attach({ floating_window = false, timer_interval = 500 })
					end

					if presentLspStatus then
						lsp_status.on_attach(client)
					end

					if client.name == "tsserver" then
						-- let prettier format
						client.server_capabilities.document_formatting = false
						client.server_capabilities.documentFormattingProvider = false
					end

					-- Mappings.
					opts = { noremap = true, silent = true }
					vim.keymap.set("n", ";d", "<cmd>Telescope diagnostics<cr>", opts)
					-- Diagnostic keymaps
					vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
					vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })

					local nmap = function(keys, func, desc)
						if desc then
							desc = "LSP: " .. desc
						end

						vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
					end

					nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					nmap(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- See `:help K` for why this keymap
					nmap("K", vim.lsp.buf.hover, "Hover Documentation")
					nmap("<leader>K", vim.lsp.buf.signature_help, "Signature Documentation")

					-- Lesser used LSP functionality
					nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
					nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
					nmap("<leader>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, "[W]orkspace [L]ist Folders")

					-- Create a command `:Format` local to the LSP buffer
					vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
						vim.lsp.buf.format()
					end, { desc = "Format current buffer with LSP" })
					nmap("<leader>lF", ":Format<cr>", "Format File")
				end

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

				require("typescript").setup({
					disable_commands = false, -- prevent the plugin from creating Vim commands
					debug = false, -- enable debug logging for commands
					go_to_source_definition = {
						fallback = true, -- fall back to standard LSP definition on failure
					},
					server = {
						-- pass options to lspconfig's setup method
						on_attach = function(_, bufnr)
							-- You can find more commands in the documentation:
							-- https://github.com/jose-elias-alvarez/typescript.nvim#commands
							vim.keymap.set("n", "<leader>cr", "<cmd>TypescriptRemoveUnused<cr>", {
								buffer = bufnr,
							})
							vim.keymap.set("n", "<leader>co", "<cmd>TypescriptOrganizeImports<cr>", {
								buffer = bufnr,
							})
							vim.keymap.set("n", "<leader>ci", "<cmd>TypescriptAddMissingImports<cr>", {
								buffer = bufnr,
							})
							vim.keymap.set("n", "<leader>cf", "<cmd>TypescriptFixAll<cr>", {
								buffer = bufnr,
							})
						end,
						filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
						cmd = { "typescript-language-server", "--stdio" },
						capabilities = capabilities,
						flags = {
							allow_incremental_sync = true,
						},
					},
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
						underline = false,
						update_in_insert = false,
						virtual_text = { spacing = 6, prefix = "●" },
						severity_sort = true,
					})

				vim.diagnostic.config({
					virtual_text = {
						prefix = "●",
					},
					update_in_insert = true,
					float = {
						source = "if_many", -- Or "if_many"
					},
				})
			end
		end,
	},
}
