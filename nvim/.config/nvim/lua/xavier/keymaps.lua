local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Add this to your init.lua to load keymaps
-- require('user.keymaps')

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- File explorer
keymap("n", "<leader>e", ":Neotree toggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)

-- TypeScript specific
keymap("n", "<leader>ti", ":TypescriptAddMissingImports<CR>", opts)
keymap("n", "<leader>to", ":TypescriptOrganizeImports<CR>", opts)
keymap("n", "<leader>tu", ":TypescriptRemoveUnused<CR>", opts)
keymap("n", "<leader>tr", ":TypescriptRenameFile<CR>", opts)

-- Next.js specific
keymap("n", "<leader>xx", ":TroubleToggle<CR>", opts)
keymap("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", opts)
keymap("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", opts)

-- Formatter
keymap("n", "<leader>fm", ":Format<CR>", opts)