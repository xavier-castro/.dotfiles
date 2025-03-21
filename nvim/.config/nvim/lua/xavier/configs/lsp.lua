local lspconfig = require("lspconfig")
-- Remove direct require to avoid circular dependency
local which_key_on_attach

-- Load the on_attach function after we know it exists
vim.api.nvim_create_autocmd("User", {
	pattern = "WhichKeyLoaded",
	callback = function()
		which_key_on_attach = require("xavier.configs.which-key").on_attach
	end,
})

require("neodev").setup()
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		-- TypeScript is handled by typescript-tools.nvim
		"eslint",
		"tailwindcss",
		"cssls",
	},
})

-- LSP configuration handler function
local function on_attach(client, bufnr)
	-- Enable inlay hints if available
	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(true, {
			bufnr = bufnr,
		})
	end

	-- Apply which-key mappings if available
	if which_key_on_attach then
		which_key_on_attach(client, bufnr)
	end
end

-- Common LSP options
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- LSP server configurations for other servers
require("mason-lspconfig").setup_handlers({
	function(server_name)
		-- Skip tsserver as we're using typescript-tools.nvim
		if server_name == "tsserver" then
			return
		end

		local opts = {
			capabilities = capabilities,
			on_attach = on_attach,
		}

		-- Special configs for specific servers
		if server_name == "lua_ls" then
			opts.settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			}
		end

		lspconfig[server_name].setup(opts)
	end,
})

-- Global mappings for diagnostics
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Set diagnostic to location list" })
