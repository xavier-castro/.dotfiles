-- XC
--
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open file nav" })
vim.keymap.set("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--

-- Goto next/prev error in qflist
vim.keymap.set("n", "<C-j>", "<Cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<Cmd>cprev<CR>zz")

-- Toggle qflist window
vim.keymap.set(
  "n",
  "<Leader>q",
  function() vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and "cclose" or "copen") end
)

-- Add all diagnostics to the qflist
vim.keymap.set("n", "grq", function()
  vim.diagnostic.setqflist { open = false }
  pcall(vim.cmd.cc)
end)

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("i", "jk", "<C-c>")
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

-- xavier-castro + theprimeagen settings
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = "Tmux Sessionizer" })

vim.keymap.set(
  "n",
  "<M-o>",
  function() vim.cmd [[ silent !tmux new-window /Users/xavier/.opencode/bin/opencode]] end,
  { desc = "Open Opencode" }
)

vim.keymap.set(
  "n",
  "<M-g>",
  function() vim.cmd [[ silent !tmux new-window /usr/local/bin/gemini]] end,
  { desc = "Open Gemini" }
)

vim.keymap.set(
  "n",
  "<M-c>",
  function() vim.cmd [[ silent !tmux new-window /Users/xavier/.volta/bin/claude --dangerously-skip-permissions]] end,
  { desc = "Open Claude CLI" }
)

vim.keymap.set(
  "n",
  "<M-m>",
  function() vim.cmd [[ silent !tmux new-window nb]] end,
  { desc = "Open my personal notes" }
)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

require "xavier.scripts.floating-term"
