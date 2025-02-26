vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true
-- vim.wo.number = false
-- vim.wo.rnu = false
vim.opt.colorcolumn = "0"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
vim.opt.laststatus = 3
vim.opt.colorcolumn = "80"

-- Enable folding ( setup in nvim-ufo )
vim.o.foldenable = true -- Enable folding by default
vim.o.foldmethod = "manual" -- Default fold method (change as needed)
vim.o.foldlevel = 99 -- Open most folds by default
vim.o.foldcolumn = "0"

-- Enable persistent folds
vim.opt.viewoptions = "folds,cursor" -- Save folds and cursor position
vim.opt.sessionoptions:append("folds") -- Include folds in sessions

-- Create directory for view files if it doesn't exist
local view_dir = vim.fn.stdpath("data") .. "/view"
if vim.fn.isdirectory(view_dir) == 0 then
	vim.fn.mkdir(view_dir, "p")
end

-- Set up autocommands to save and load folds
vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
	pattern = { "*.*" },
	command = "silent! mkview",
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*.*" },
	command = "silent! loadview",
})

-- backspace
vim.opt.backspace = { "start", "eol", "indent" }

--split windows
vim.opt.splitright = true --split vertical window to the right
vim.opt.splitbelow = true --split horizontal window to the bottom
