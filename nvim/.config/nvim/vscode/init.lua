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
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<Tab>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<cr>", {})
vim.keymap.set("n", "<S-Tab>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<cr>", {})

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
