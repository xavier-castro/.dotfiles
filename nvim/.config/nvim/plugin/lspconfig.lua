local present, ufo = pcall(require, "ufo")

local setupWithFallback = function()
	if not present then
		vim.notify("ufo not installed")

		-- fold
		vim.wo.foldcolumn = "0" -- defines 1 col at window left, to indicate folding
		vim.o.foldlevelstart = 99 -- start file with all folds opened

		-- using treesitter for folding
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

		return
	end

	local ftMap = {
		vim = "indent",
		git = "",
	}

	local function customizeSelector(bufnr)
		local function handleFallbackException(err, providerName)
			if type(err) == "string" and err:match("UfoFallbackException") then
				return ufo.getFolds(bufnr, providerName)
			else
				return require("promise").reject(err)
			end
		end

		return ufo.getFolds(bufnr, "lsp")
			:catch(function(err)
				return handleFallbackException(err, "treesitter")
			end)
			:catch(function(err)
				return handleFallbackException(err, "indent")
			end)
	end

	ufo.setup({
		provider_selector = function(_, filetype, _)
			return ftMap[filetype] or customizeSelector
		end,
	})

	vim.keymap.set("n", "zR", ufo.openAllFolds)
	vim.keymap.set("n", "zM", ufo.closeAllFolds)

	vim.o.foldcolumn = "0" -- '0' is not bad
	vim.o.foldlevel = 99
	vim.o.foldlevelstart = 99
	vim.o.foldenable = true
	vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
	-- done by statuscolumn plugin
	--[[ vim.o.statuscolumn = "%=%l%s%C" ]]
end

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
	local opts = { buffer = bufnr, remap = false }
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
		vim.keymap.set("n", "<leader>nls", "<cmd>NullLsInfo<cr>", opts)
		vim.keymap.set("n", ";d", "<cmd>Telescope diagnostics<cr>", opts)
	end

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
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
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

if present then
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
end

nvim_lsp.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
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
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
	settings = {
		format = { enable = true },
	},
})

nvim_lsp.flow.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
})

nvim_lsp.tsserver.setup({
	on_attach = on_attach,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
})

nvim_lsp.sourcekit.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
})

nvim_lsp.efm.setup({
	init_options = { documentFormatting = true },
	settings = {
		rootMarkers = { ".git/" },
		languages = {
			lua = { { formatCommand = "lua-format -i", formatStdin = true } },
		},
	},
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
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
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
})

nvim_lsp.tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
})

-- nvim_lsp.pylsp.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	flags = {
-- 		debounce_text_changes = 200,
-- 		allow_incremental_sync = true,
-- 	},
-- })

pyright = "pyright-langserver"
nvim_lsp.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
})

nvim_lsp.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
})

nvim_lsp.astro.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = {
		debounce_text_changes = 200,
		allow_incremental_sync = true,
	},
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

setupWithFallback()

vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
	},
	update_in_insert = true,
	float = {
		source = "always", -- Or "if_many"
	},
})
