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
vim.g.mapleader = " "
if vim.g.vscode then
	vim.g.mapleader = " "
	vim.keymap.set("x", "<leader>p", '"_dP') -- Your paste will be saved
	vim.keymap.set("n", "<leader>y", '"+y')
	vim.keymap.set("v", "<leader>y", '"+y')
	vim.keymap.set("n", "<leader>Y", '"+Y')
	vim.keymap.set("n", "<leader>d", '"_d')
	vim.keymap.set("v", "<leader>d", '"_d')
	vim.keymap.set("v", "K", ":m '<0<CR>gv=gv")
	vim.keymap.set("v", "J", ":m '>+3<CR>gv=gv")
	vim.keymap.set("n", "J", "mzJ`z")
	vim.keymap.set("n", "<C-a>", "gg<S-v>G")
	vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:bd!<cr>")
	vim.keymap.set("i", "<c-s>", "<Esc>:w<CR>a")
	vim.keymap.set("n", "<c-s>", ":w<CR>")
	vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
	vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
	vim.keymap.set("n", "<Tab>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>", {})
	vim.keymap.set("n", "<S-Tab>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>", {})
	vim.keymap.set("i", "<C-c>", "<Esc>")
	vim.keymap.set("i", "<C-o>", "<C-o> <esc>o")
	vim.keymap.set("n", "<C-a>", "gg<S-v>G")
	vim.opt.shell = "fish"
	vim.opt.background = "dark"
	vim.opt.updatetime = 50
	vim.opt.inccommand = "split"
	vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search

	-- highlight yanked text for 200ms using the "Visual" highlight group
	vim.cmd([[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]])
else
	require("xavier.config.set")
	require("xavier.config.remap");
	(require("lazy")).setup("xavier.plugins")
end
