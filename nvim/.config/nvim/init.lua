-- ~/.config/nvim/init.lua
-- Entry point for Neovim configuration
vim.g.mapleader = " " -- Set leader key to space
vim.g.maplocalleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("core.options")
require("core.keymaps")
require("core.user_commands")

-- Initialize lazy.nvim
require("lazy").setup("plugins", {
	install = {
		colorscheme = { "xcnoir" },
	},
	checker = {
		enabled = true,
		notifdetection = {
			notify = false,
		},
	},
})
