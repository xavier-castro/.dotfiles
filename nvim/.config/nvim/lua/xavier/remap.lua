vim.keymap.set("n", "<leader>ff", function()
	vim.lsp.buf.format({ timeout_ms = 4000 })
end)
