vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")
vim.keymap.set("n", "te", ":tabedit")
vim.keymap.set("n", "dw", 'vb"_d')
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set("n", "te", ":tabedit<cr>")
vim.keymap.set("n", "ss", ":split<Return><C-w>w")
vim.keymap.set("n", "sv", ":vsplit<Return><C-w>w")
-- Move window
vim.keymap.set("", "sh", "<C-w>h")
vim.keymap.set("", "sk", "<C-w>k")
vim.keymap.set("", "sj", "<C-w>j")
vim.keymap.set("", "sl", "<C-w>l")
vim.keymap.set("", "s_", "<C-w>_")
vim.keymap.set("", "s\\", "<C-w>|")
vim.keymap.set("", "s=", "<C-w>=")
-- Resize window
vim.keymap.set("n", "<C-w><left>", "<C-w><")
vim.keymap.set("n", "<C-w><right>", "<C-w>>")
vim.keymap.set("n", "<C-w><up>", "<C-w>+")
vim.keymap.set("n", "<C-w><down>", "<C-w>-")
-- XC QOL
vim.keymap.set("n", "<Esc>", ":nohl<cr>")
-- primeagen QOL
-- Move around highlighted
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>:bd!<cr>")
vim.keymap.set("n", "<M-d>", "<cmd>ToggleTerm<cr>")
vim.keymap.set("x", "<leader>p", '"_dP') -- Your paste will be saved

-- Yank and keep outside of vim
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>F", "<cmd>Telescope<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fl", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>m", "<cmd>Telescope marks<cr>")
vim.keymap.set("n", "<leader>M", "<cmd>Telescope man_pages<cr>")
vim.keymap.set("n", "<leader>F", "<cmd>Telescope<cr>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format({ timeout_ms = 4000 })
end)
vim.keymap.set("i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
vim.keymap.set("s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>")
vim.keymap.set("i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>")
vim.keymap.set("s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR")
vim.keymap.set(
	"n",
	"<leader>cpt",
	"<cmd>Copilot suggestion toggle_auto_trigger<CR>:lua require('notify')('Copilot Toggled')<cr>"
)
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>so", function()
	vim.cmd("so")
end)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- remap to open the Telescope refactoring menu in visual mode
vim.api.nvim_set_keymap(
	"v",
	"<leader>rr",
	"<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>",
	{ noremap = true }
)
