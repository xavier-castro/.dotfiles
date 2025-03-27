-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- XC Defaults
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("i", "jk", "<Esc>")

-- Resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")

-- Notificationd
-- stylua: ignore
vim.keymap.set("n", "<leader>oN", function() Snacks.picker.notifications() end, { desc = "Notifications" })
-- stylua: ignore
vim.keymap.set("n", "<leader>on", function() Snacks.notifier.show_history() end, { desc = "Notifications(win)" })

-- Util functions called here
require("utils.vscode-like-quickfix")
require("utils.search-files")
require("utils.float-terminal")
