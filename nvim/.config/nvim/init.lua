-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Load plugins with Lazy
require("xavier.lazy")

-- Initialize which-key after plugins are loaded
vim.api.nvim_create_autocmd("User", {
	pattern = "LazyDone",
	callback = function()
		-- Trigger event to let LSP know which-key is ready
		local which_key = require("xavier.configs.which-key")
		which_key.setup()
		vim.api.nvim_exec_autocmds("User", { pattern = "WhichKeyLoaded" })
	end,
})

-- Load keymaps
require("xavier.keymaps")

