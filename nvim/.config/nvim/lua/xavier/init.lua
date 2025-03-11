local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("lazy").setup({
	{ import = "xavier.plugins_notvscode", cond = (function() return not vim.g.vscode end) },
	{ import = "xavier.plugins_always",    cond = true },
    { import = "xavier.plugins_vscode",    cond = (function() return vim.g.vscode end) },
})