-- Edit Snippets
vim.keymap.set("n", ";s", ":lua require('luasnip.loaders').edit_snippet_files()<cr>")

vim.keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set("n", "te", ":tabedit<cr>")
vim.keymap.set("n", "ss", ":split<Return><C-w>w")
vim.keymap.set("n", "sS", ":split<Return><C-6><C-w>w")
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w")
vim.keymap.set("n", "sV", ":vsplit<Return><C-6><C-w>w")
vim.keymap.set("", "sh", "<C-w>h")
vim.keymap.set("", "sqq", "<C-w>q")
vim.keymap.set("", "sk", "<C-w>k")
vim.keymap.set("", "sj", "<C-w>j")
vim.keymap.set("", "sl", "<C-w>l")
vim.keymap.set("", "s_", "<C-w>_")
vim.keymap.set("", "s\\", "<C-w>|")
vim.keymap.set("", "s=", "<C-w>=")
vim.keymap.set("n", "<C-left>", "<C-w><")
vim.keymap.set("n", "<C-right>", "<C-w>>")
vim.keymap.set("n", "<C-up>", "<C-w>+")
vim.keymap.set("n", "<C-down>", "<C-w>-")
vim.keymap.set("n", "<Esc>", ":nohl<cr>")
vim.keymap.set("i", "<c-s>", "<Esc>:w<CR>a")
vim.keymap.set("n", "<c-s>", ":w<CR>")

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.dotfiles/bin/.local/scripts/tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])