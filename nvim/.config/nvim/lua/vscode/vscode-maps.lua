vim.g.mapleader = " "
vim.keymap.set("x", "<leader>p", '"_dP') -- Your paste will be saved

-- Yank and keep outside of vim
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

