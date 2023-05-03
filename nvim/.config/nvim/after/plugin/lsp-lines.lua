local r = require("xavier.utils.remaps")
local lsp_lines = require("lsp_lines")

r.map("n", "<leader>le", function()
	local current_value = vim.diagnostic.config().virtual_text
	vim.diagnostic.config({
		virtual_text = not current_value,
		virtual_lines = current_value,
	})
	return current_value
end, "Toggle lsp_lines")

lsp_lines.setup()
