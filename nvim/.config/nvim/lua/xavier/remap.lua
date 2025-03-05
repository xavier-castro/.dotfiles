vim.g.mapleader = " "
vim.g.maplocalleader = "//"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "-", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>ff", function()
	require("conform").format({ async = true })
end)

vim.keymap.set("n", "<leader>fF", function()
	-- Regular LSP Format
	vim.lsp.buf.format()
end)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>s", "GrugFar<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Reset LSP
-- For all lsp's sometimes manual lsp restart is required
vim.keymap.set("n", "<leader>ol", "<cmd>LspRestart<CR>", { desc = "Lsp restart", silent = true })

-- Resize
vim.keymap.set("n", "<C-w><left>", "<C-w><", {})
vim.keymap.set("n", "<C-w><right>", "<C-w>>", {})
vim.keymap.set("n", "<C-w><up>", "<C-w>+", {})
vim.keymap.set("n", "<C-w><down>", "<C-w>-", {})

-- Yank Diagnostisc to Keyboard
-- Yank diagnostics to clipboard
-- TODO: Make it so I get some sort of message when I use this
vim.keymap.set("n", "<leader>oY", function()
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diagnostics = vim.diagnostic.get(0, { lnum = line })
	local lines = {}
	for _, d in ipairs(diagnostics) do
		table.insert(lines, d.message)
	end
	vim.fn.setreg("+", table.concat(lines, "\n"))
end, { desc = "Yank diagnostics" })
