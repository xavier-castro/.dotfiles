require("xavier.set")
require("xavier.remap")
require("xavier.lazy_init")

local augroup = vim.api.nvim_create_augroup
local xavierGroup = augroup("xavier", {})
local foldGroup = augroup("FoldPersistence", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

-- Save folds when leaving a buffer, load when entering
autocmd({ "BufWinLeave" }, {
	group = foldGroup,
	pattern = { "*" },
	command = "silent! mkview",
})

autocmd({ "BufWinEnter" }, {
	group = foldGroup,
	pattern = { "*" },
	command = "silent! loadview",
})

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = xavierGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "json", "jsonc", "markdown" },
	callback = function()
		vim.opt.conceallevel = 0
	end,
})

require("xavier.utils.floating_terminal")
require("xavier.utils.note_lookup")

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.cmd.colorscheme("rose-pine")
