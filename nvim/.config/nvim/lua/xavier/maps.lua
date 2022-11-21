local Remap = require("xavier.keymap")
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--Remap space as leader key
vim.api.nvim_set_keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Personal settings
Remap.nnoremap("<leader>lf", "<cmd>Prettier<cr>")
Remap.nnoremap("<leader>h", ":nohl<cr>")
Remap.inoremap("jk", "<esc>")
Remap.nnoremap("<leader>s", ":set wrap!<cr>")
Remap.nnoremap("<leader><C-r>", "gd[{V%::s/<C-R>///gc<left><left><left>") -- local replace
Remap.nnoremap("<leader><C-R>", "gD:%s/<C-R>///gc<left><left><left>") -- global replace
Remap.nnoremap("<leader>rg", '<cmd>lua require("xavier.functions").ripgrep()<cr>')
-- Harpoon
Remap.nnoremap("mm", "<cmd>lua require('harpoon.mark').add_file()<cr>")
Remap.nnoremap(";m", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")

-- New tab
keymap.set('n', 'te', ':tabedit')
Remap.nnoremap("tt", "<C-w>T") -- Create new tab off current window

-- Split window
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')
keymap.set('', 'sq', '<C-w>q')
-- Resize window
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')
Remap.nnoremap("s==", "<C-w>|") -- Maximizes window size horizontally
Remap.nnoremap("s--", "<C-w>_") -- Maximizes window size vertically
Remap.nnoremap("s=", "<C-w>=") -- Equally sizes window
