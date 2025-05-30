-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Open scratch buffer
vim.keymap.set('n', '<leader>bs', function()
  vim.cmd 'enew' -- Create a new empty buffer.
  -- Set scratch buffer options.
  vim.opt_local.buftype = 'nofile'
  vim.opt_local.bufhidden = 'hide' -- Keeps buffer in memory when switching.
  vim.opt_local.swapfile = false
  -- Prevent auto-session from saving this buffer.
  vim.b.auto_session_enabled = false
  -- Generate a unique buffer name, e.g., using the current date/time.
  local name = 'Scratch-' .. os.date '%m%d-%H:%M:%S'
  vim.cmd('file ' .. name)

  -- Custom variable to track scratch buffers
  vim.b.scratch_buffer = true
  -- Autocmd to change bufhidden to 'wipe' only when exiting Neovim.
  vim.api.nvim_create_autocmd('VimLeavePre', {
    buffer = 0, -- Apply to the current buffer
    callback = function()
      vim.opt_local.bufhidden = 'delete'
      vim.cmd 'bdelete!'
    end,
  })
end, { desc = '[B]uffer [S]cratch' })

-- Save scratch buffer
vim.keymap.set('n', '<leader>bw', ':setlocal buftype= | w<CR>', { desc = '[B]uffer [W]rite Scratch' })

-- Single ESC to enter normal mode, <Esc><Esc> to close terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Terminal: Enter normal mode' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>:bd!<CR>', { desc = 'Terminal: Close terminal' })

-- Open a terminal buffer
vim.keymap.set('n', '<leader>tt', ':terminal<CR>i', { desc = '[T]erminal: Open [t]erminal' })

-- Add floating terminal keymap
local float_terminal = require 'xavier.helpers.float-terminal'
vim.keymap.set({ 'n', 't' }, '<leader>tf', float_terminal.toggle_terminal, { desc = '[T]oggle [f]loating terminal' })

-- Disable line numbers in terminal buffers
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('terminal_settings', { clear = true }),
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Add bottom and right terminal splits
vim.keymap.set('n', '<leader>tb', function()
  vim.cmd('botright ' .. math.ceil(vim.fn.winheight(0) * 0.3) .. 'sp | term')
end, { desc = 'Launch a [T]erminal in the [B]ottom' })

vim.keymap.set('n', '<leader>tr', function()
  vim.cmd('bot ' .. math.ceil(vim.fn.winwidth(0) * 0.3) .. 'vs | term')
end, { desc = 'Launch a [T]erminal to the [R]ight' })

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

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
-- vim.keymap.set('n', '<down>', '<cd>echo "Use j to move!!"<CR>')

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
--
vim.keymap.set('i', 'jk', '<C-c>')

vim.keymap.set('n', '<leader>lf', function()
  require('conform').format { async = false, lsp_format = 'fallback', timeout_ms = 5000 }
end)
vim.keymap.set('v', '<leader>lf', function()
  require('conform').format { async = false, lsp_format = 'fallback', timeout_ms = 5000 }
end)

vim.keymap.set('n', '<C-f>', '<cmd>silent tmux-sessionizer<CR>')

-- Remap adding surrounding to Visual mode selection
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { desc = '[S]urround' })
