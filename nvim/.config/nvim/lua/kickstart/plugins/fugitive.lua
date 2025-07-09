-- -- Alternatively, use `config = function() ... end` for full control over the configuration.
-- -- If you prefer to call `setup` explicitly, use:
-- --    {
-- --        'lewis6991/gitsigns.nvim',
-- --        config = function()
-- --            require('gitsigns').setup({
-- --                -- Your gitsigns configuration here
-- --            })
-- --        end,
-- --    }
-- --
-- -- Here is a more advanced example where we pass configuration
-- -- options to `gitsigns.nvim`.
-- --
-- -- See `:help gitsigns` to understand what the configuration keys do
-- return {
--   { -- Adds git related signs to the gutter, as well as utilities for managing changes
--     'lewis6991/gitsigns.nvim',
--     opts = {
--       signs = {
--         add = { text = '+' },
--         change = { text = '~' },
--         delete = { text = '_' },
--         topdelete = { text = '‾' },
--         changedelete = { text = '~' },
--       },
--       on_attach = function(bufnr)
--         local gitsigns = require 'gitsigns'
--
--         local function map(mode, l, r, opts)
--           opts = opts or {}
--           opts.buffer = bufnr
--           vim.keymap.set(mode, l, r, opts)
--         end
--
--         -- Navigation
--         map('n', ']c', function()
--           if vim.wo.diff then
--             vim.cmd.normal { ']c', bang = true }
--           else
--             gitsigns.nav_hunk 'next'
--           end
--         end, { desc = 'Jump to next git [c]hange' })
--
--         map('n', '[c', function()
--           if vim.wo.diff then
--             vim.cmd.normal { '[c', bang = true }
--           else
--             gitsigns.nav_hunk 'prev'
--           end
--         end, { desc = 'Jump to previous git [c]hange' })
--
--         -- Actions
--         -- visual mode
--         map('v', '<leader>hs', function()
--           gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
--         end, { desc = 'git [s]tage hunk' })
--         map('v', '<leader>hr', function()
--           gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
--         end, { desc = 'git [r]eset hunk' })
--         -- normal mode
--         map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
--         map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
--         map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
--         map('n', '<leader>hu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
--         map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
--         map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
--         map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
--         map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
--         map('n', '<leader>hD', function()
--           gitsigns.diffthis '@'
--         end, { desc = 'git [D]iff against last commit' })
--         -- Toggles
--         map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
--         map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
--       end,
--     },
--   },
-- }
-- -- vim: ts=2 sts=2 sw=2 et

return {
  'tpope/vim-fugitive',
  config = function()
    vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

    local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup('ThePrimeagen_Fugitive', {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('BufWinEnter', {
      group = ThePrimeagen_Fugitive,
      pattern = '*',
      callback = function()
        if vim.bo.ft ~= 'fugitive' then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set('n', '<leader>p', function()
          vim.cmd.Git 'push'
        end, opts)

        -- rebase always
        vim.keymap.set('n', '<leader>P', function()
          vim.cmd.Git { 'pull', '--rebase' }
        end, opts)

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set('n', '<leader>t', ':Git push -u origin ', opts)
      end,
    })

    vim.keymap.set('n', 'gu', '<cmd>diffget //2<CR>')
    vim.keymap.set('n', 'gh', '<cmd>diffget //3<CR>')
  end,
}
