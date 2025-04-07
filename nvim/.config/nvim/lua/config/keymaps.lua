-- Set the leader key to space
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"

-- Clear search highlighting
vim.keymap.set('n', '<leader>ch', ':let @/=""<CR>')

-- Highlight all words under cursor
-- vim.keymap.set('n', '<leader>hw', ':let @/=expand("<cword>")<CR>')
vim.keymap.set('n', '<leader>hw', ':let @/=expand("<cword>")<CR>:set hlsearch<CR>')

-- Navigate between windows using Ctrl + arrow keys
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')

-- Use this for navigation in terminal mode
vim.keymap.set('t', '<C-k>', [[<C-\><C-n><C-W>k]])

-- Enter normal mode in a terminal buffer.
vim.keymap.set('t', '<C-o>', '<C-\\><C-n>')

-- Make all windows equal size
vim.keymap.set('n', '<leader>rw', '<C-W>=')

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Util
require("float-terminal")
require("fuzzysearch")
