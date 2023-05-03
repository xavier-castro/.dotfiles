local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.setup({
	preview = {
		lines_above = 0,
		lines_below = 10,
	},
	request_timeout = 8000,
	ui = {
		winblend = 10,
		border = "rounded",
		colors = {
			normal_bg = "#002b36",
		},
	},
	lightbulb = {
		enable = false,
		enable_in_insert = true,
		sign = true,
		sign_priority = 40,
		virtual_text = true,
	},
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gl", "<Cmd>Lspsaga show_diagnostic<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<Cr>", opts)
vim.keymap.set("n", "<leader>gr", "<cmd>Lspsaga rename ++project<CR>")
vim.keymap.set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "<leader>o", "<Cmd>Lspsaga outline<cr>", opts)
-- Diagnostic jump with filters such as only jumping to an error
vim.keymap.set("n", "[D", function()
	require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set("n", "]D", function()
	require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

-- code action
local codeaction = require("lspsaga.codeaction")
vim.keymap.set("n", "<M-.>", function()
	codeaction:code_action()
end, { silent = true })
-- code action
vim.keymap.set("n", "<leader>ca", function()
	codeaction:code_action()
end, { silent = true })
vim.keymap.set("v", "<leader>ca", function()
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
	codeaction:range_code_action()
end, { silent = true })
vim.keymap.set("v", "<M-.>", function()
	vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
	codeaction:range_code_action()
end, { silent = true })
