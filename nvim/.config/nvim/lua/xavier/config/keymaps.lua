vim.g.mapleader = " "
-- Edit Snippets
vim.keymap.set("n", ";s", ":lua require('luasnip.loaders').edit_snippet_files()<cr>")

vim.keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set("n", "te", ":tabedit<cr>")
vim.keymap.set("n", "ss", ":split<Return><C-w>w")
vim.keymap.set("n", "sS", ":split<Return><C-6><C-w>w")
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w")
vim.keymap.set("n", "sV", ":vsplit<Return><C-6><C-w>w")
-- Move window
vim.keymap.set("", "sh", "<C-w>h")
vim.keymap.set("", "sqq", "<C-w>q")
vim.keymap.set("", "sk", "<C-w>k")
vim.keymap.set("", "sj", "<C-w>j")
vim.keymap.set("", "sl", "<C-w>l")
vim.keymap.set("", "s_", "<C-w>_")
vim.keymap.set("", "s\\", "<C-w>|")
vim.keymap.set("", "s=", "<C-w>=")
-- Resize window
vim.keymap.set("n", "<C-left>", "<C-w><")
vim.keymap.set("n", "<C-right>", "<C-w>>")
vim.keymap.set("n", "<C-up>", "<C-w>+")
vim.keymap.set("n", "<C-down>", "<C-w>-")
-- XC QOL
vim.keymap.set("n", "<Esc>", ":nohl<cr>")
-- primeagen QOL
-- Move around highlighted
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:bd!<cr>")
vim.keymap.set("x", "<leader>p", '"_dP') -- Your paste will be saved

-- Yank and keep outside of vim
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.dotfiles/bin/.local/scripts/tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>fz", "<cmd>LspZeroFormat<CR>")
vim.keymap.set("n", "<leader>fp", "<cmd>Prettier<CR>")
vim.keymap.set("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
vim.keymap.set("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
vim.keymap.set("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
vim.keymap.set("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)
-- Save and Write in Insert
vim.keymap.set("i", "<c-s>", "<Esc>:w<CR>a")
vim.keymap.set("n", "<c-s>", ":w<CR>")
-- Delete Marks
