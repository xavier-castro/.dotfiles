local M = {}
-- Set colorscheme after options
vim.cmd([[colorscheme neosolarized]])

function M.ColorMyPencils(color)
	color = color or "neosolarized"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

M.ColorMyPencils()

vim.keymap.set(
	"n",
	"<leader>8",
	":lua require('xavier.util.colors').ColorMyPencils()<CR>",
	{ noremap = true, silent = true }
)

return M
