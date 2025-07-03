-- [[ Basic Keymaps ]]

-- XC
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('t', '<C-x>', '<C-\\><C-N>', { desc = 'terminal escape terminal mode' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('i', 'jk', '<C-c>')
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', '=ap', "ma=ap'a")
-- greatest remap ever
vim.keymap.set('x', '<leader>p', [["_dP]])
-- next greatest remap ever : asbjornHaland
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d')
-- This is going to get me cancelled
vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', 'Q', '<nop>')

-- xavier-castro + theprimeagen settings
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>', { desc = 'Tmux Sessionizer' })
vim.keymap.set('n', '<M-o>', function()
  vim.cmd [[ silent !tmux new-window /Users/xavier/.opencode/bin/opencode]]
end, { desc = 'Open Opencode' })

vim.keymap.set('n', '<M-g>', function()
  vim.cmd [[ silent !tmux new-window /Users/xavier/.volta/bin/gemini]]
end, { desc = 'Open Gemini' })

vim.keymap.set('n', '<M-c>', function()
  vim.cmd [[ silent !tmux new-window /Users/xavier/.volta/bin/claude  --dangerously-skip-permissions]]
end, { desc = 'Open Claude CLI' })

vim.keymap.set('n', '<leader>f', function()
  require('conform').format { bufnr = 0 }
end)

vim.keymap.set('i', '<C-c>', '<Esc>')
vim.keymap.set('n', 'Q', '<nop>')

vim.keymap.set('n', '<M-h>', '<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>')
vim.keymap.set('n', '<M-H>', '<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>')

vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Goto next/prev error in qflist
vim.keymap.set('n', '<C-j>', '<Cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-k>', '<Cmd>cprev<CR>zz')

-- Toggle qflist window
vim.keymap.set('n', '<Leader>q', function()
  vim.cmd(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and 'cclose' or 'copen')
end)

-- Add all diagnostics to the qflist
vim.keymap.set('n', 'grq', function()
  vim.diagnostic.setqflist { open = false }
  pcall(vim.cmd.cc)
end)

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

require 'xavier.scripts.floating_term'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

--
local augroup = vim.api.nvim_create_augroup
local XavierGroup = augroup('Xavier', {})
local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'BufWritePre' }, { group = XavierGroup, pattern = '*', command = [[%s/\s\+$//e]] })

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json', 'jsonc', 'markdown' },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- Persist folds with mkview and loadview
autocmd('BufWinLeave', {
  group = vim.api.nvim_create_augroup('view_folds', { clear = true }),
  pattern = '*',
  command = 'silent! mkview',
})
autocmd('BufWinEnter', {
  group = vim.api.nvim_create_augroup('view_folds_load', { clear = true }),
  pattern = '*',
  command = 'silent! loadview',
})

-- vim: ts=2 sts=2 sw=2 et
