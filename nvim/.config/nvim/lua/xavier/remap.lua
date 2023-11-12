-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
local utils = require 'xavier.utils'

-- Open vim explorer [replaced by neo-tree]
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Move selected lines around
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'H', '<gv')
vim.keymap.set('v', 'L', '>gv')

-- Replace the highlighted word
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace highlighted word' })

-- Horizontal and vertical splits
vim.keymap.set('n', 'ss', '<cmd>split<CR><C-w>w', { desc = 'Horizontal split' })
vim.keymap.set('n', 'sv', '<cmd>vsplit<CR><C-w>w', { desc = 'Vertical split' })

-- Navigate between nvim splits
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Close window
vim.keymap.set('n', '<C-q>', '<C-w>q')

-- Tabs navigation
vim.keymap.set('n', 'te', '<cmd>tabedit<CR>', { desc = 'New tab' })
vim.keymap.set('n', 'H', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', 'L', '<cmd>tabnext<CR>', { desc = 'Next tab' })

-- Tabs move
vim.keymap.set('n', '<t', '<cmd>tabmove -1<CR>', { desc = 'Move tab left' })
vim.keymap.set('n', '>t', '<cmd>tabmove +1<CR>', { desc = 'Move tab right' })

-- Toggle wrap
vim.keymap.set('n', '<leader>uw', function()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify('Wrap ' .. (vim.wo.wrap and 'enabled' or 'disabled'))
end, { desc = 'Toggle wrap' })

-- Keymap to open lazygit in zellij floating pane
-- This should be compatible with worktrees
if vim.env.ZELLIJ == '0' and vim.fn.executable 'lazygit' == 1 then
  vim.keymap.set('n', '<leader>gg', function()
    local Job = require 'plenary.job'

    local function open_lazygit_in_zellij_floating_page()
      local worktree = utils.file_worktree()
      local args = {
        'run',
        '-f',
        '--name',
        'lazygit',
        '--',
        'lazygit',
      }

      if worktree then
        table.insert(args, ('--work-tree=%s'):format(worktree.toplevel))
        table.insert(args, ('--git-dir=%s'):format(worktree.gitdir))
      end

      Job:new({
        command = 'zellij',
        args = args,
      }):start()
    end

    open_lazygit_in_zellij_floating_page()
  end, { desc = 'Open lazygit in zellij floating page' })
end
