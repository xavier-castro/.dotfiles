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

	local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
	local enable_format_on_save = function(_, bufnr)
		vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup_format,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end

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
		vim.keymap.set("n", "<leader>nls", "<cmd>NullLsInfo<cr>", opts)
		vim.keymap.set("n", ";d", "<cmd>Telescope diagnostics<cr>", opts)
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

	nvim_lsp.eslint.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		settings = {
			format = { enable = true },
		},
	})

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
			enable_format_on_save(client, bufnr)
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

	local pyright_capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
	require("lspconfig")["pyright"].setup({
		capabilities = pyright_capabilities,
		on_attach = on_attach,
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

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
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
end
