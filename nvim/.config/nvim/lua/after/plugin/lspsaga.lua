---@diagnostic disable: undefined-global
return {
	"glepnir/lspsaga.nvim",
	event = "BufRead",
	config = function()
		local saga = require("lspsaga")
		saga.setup({
			symbol_in_winbar = { false },
		})
		vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")
		vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>")
		vim.keymap.set("n", "gR", "<cmd>Lspsaga rename ++project<cr>")
		vim.keymap.set("n", "gt", "<cmd>Lspsaga preview_definition<CR>")
		vim.keymap.set("n", "gT", "<cmd>Lspsaga preview_definition ++project<cr>")
		vim.keymap.set("n", "gic", "<cmd>Lspsaga incoming_calls<cr>")
		vim.keymap.set("n", "goc", "<cmd>Lspsaga outgoing_calls<cr>")
		vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")
		vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
		vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")
		vim.keymap.set("n", "<leader>cc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
		vim.keymap.set("n", "<leader>cn", "<cmd>Lspsaga diagnostic_jump_next<CR>")
		vim.keymap.set("n", "<leader>cp", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
		vim.keymap.set("n", "<m-d>", "<cmd>Lspsaga term_toggle<CR>")
		vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<cr>")
	end,
	dependencies = {},
}
