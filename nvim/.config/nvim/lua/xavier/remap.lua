vim.g.mapleader = " "
vim.keymap.set("n", "-", ":Oil --float<CR>", { desc = "Oil File Manager" })
vim.keymap.set("n", "<leader>e", ":OtreeFocus<CR>", { desc = "Focus File Tree" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape to Normal" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join Lines" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down & Center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up & Center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next Search & Center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev Search & Center" })
vim.keymap.set("n", "=ap", "ma=ap'a", { desc = "Format Paragraph" })
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>", { desc = "LSP Restart" })

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end, { desc = "Start Vim With Me" })
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end, { desc = "Stop Vim With Me" })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste Without Overwrite" })

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to System" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank Line to System" })

vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete to Black Hole" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Escape Alt" })

vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Ex Mode" })
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux Sessionizer" })
vim.keymap.set("n", "<M-o>", function()
	vim.cmd([[ silent !tmux new-window /usr/local/bin/opencode]])
end, { desc = "Open Opencode" })

vim.keymap.set("n", "<M-c>", function()
	vim.cmd([[ silent !tmux new-window /Users/xavier/.volta/bin/claude ]])
end, { desc = "Open Claude CLI" })

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({ bufnr = 0 })
end, { desc = "Format Buffer" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next Quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev Quickfix" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "Next Location List" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "Prev Location List" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search & Replace Word Under Cursor" })
