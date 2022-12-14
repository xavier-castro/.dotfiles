-- MORE KEYMAPS ARE FOUND IN THE FOLLOWING FILES:
-- telescope.lua
-- cmp.lua
-- lspconfig
-- refactoring

local Remap = require("xavier.keymap")
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

--Remap space a; leader key
vim.api.nvim_set_keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Personal settings
-- Nvim-tree
Remap.nnoremap(";\\", ":NvimTreeToggle<cr>")
Remap.nnoremap("<leader>tsh", "<cmd>TSHighlightCapturesUnderCursor<cr>")
Remap.nnoremap("<leader>tsp", "<cmd>TSPlaygroundToggle<cr>")
Remap.nnoremap("<leader>sv", ":source $MYVIMRC<cr>")
Remap.nnoremap("<s-l>", ":bn<cr>")
Remap.nnoremap("<s-h>", ":bprevious<cr>")
Remap.nnoremap("<cr>", ":noh<cr><cr>")
Remap.nnoremap(";s", "<cmd>SymbolsOutline<cr>")
Remap.nnoremap("<leader>lp", "<cmd>Prettier<cr>")
Remap.nnoremap("<leader>h", ":nohl<cr>")
-- Remap.inoremap("jk", "<esc>")
Remap.nnoremap("<leader>tw", ":set wrap!<cr>")
Remap.nnoremap("<F5>", "<cmd>Telescope commands<cr>")
Remap.inoremap("<M-w>", "<ESC>:w<cr>a") -- Saves file in insert mode and returns back to insert mode
Remap.nnoremap("mm", "<cmd>lua require('harpoon.mark').add_file()<cr>")
Remap.nnoremap(";m", "<cmd>Telescope harpoon marks initial='insert'<cr>")
Remap.nnoremap("<leader>nw", "<cmd>lua require('harpoon.tmux').gotoTerminal(1)<cr>")
keymap.set('n', 'te', ':tabedit') -- another way to create a new tab
Remap.nnoremap("tl", ":tabs<cr>") -- List tabs
Remap.nnoremap("tn", ":tabn<cr>")
Remap.nnoremap("tp", ":tabp<cr>")
Remap.nnoremap("tt", ':tabnew<cr>') -- Create new tab off current window
Remap.nnoremap("Q", ":tabclose<cr>")
keymap.set("n", "<m-h>", "<C-w>h", opts)
keymap.set("n", "<m-j>", "<C-w>j", opts)
keymap.set("n", "<m-k>", "<C-w>k", opts)
keymap.set("n", "<m-l>", "<C-w>l", opts)
keymap.set("n", "<m-tab>", "<c-6>", opts)
keymap.set("n", "<m-t>", ":tabnew %<cr>", opts)
keymap.set("n", "<m-y>", ":tabclose<cr>", opts)
keymap.set("n", "<m-\\>", ":tabonly<cr>", opts)
keymap.set("n", "<C-Up>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
keymap.set('', 'sh', '<C-w>h')
keymap.set('', 'sk', '<C-w>k')
keymap.set('', 'sj', '<C-w>j')
keymap.set('', 'sl', '<C-w>l')
keymap.set('', 'sq', '<C-w>q')
keymap.set('n', '<C-w><left>', '<C-w><')
keymap.set('n', '<C-w><right>', '<C-w>>')
keymap.set('n', '<C-w><up>', '<C-w>+')
keymap.set('n', '<C-w><down>', '<C-w>-')
Remap.nnoremap("s|", "<C-w>|") -- Maximizes window size horizontally
Remap.nnoremap("s_", "<C-w>_") -- Maximizes window size vertically
Remap.nnoremap("s=", "<C-w>=") -- Equally sizes window
