-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- Disable the concealing in some file formats
-- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json', 'jsonc', 'markdown' },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- nvim_ds_repl plugin configuration --
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = { '*.py', '*.R' },
  callback = function()
    -- Execute the current statement or block under the cursor
    vim.keymap.set('n', '<CR>', function()
      require('pyrola').send_statement_definition()
    end, { noremap = true })

    -- Execute the selected visual block of code
    vim.keymap.set('v', '<leader>vs', function()
      require('pyrola').send_visual_to_repl()
    end, { noremap = true })

    -- Query information about the specific object under the cursor
    vim.keymap.set('n', '<leader>is', function()
      require('pyrola').inspect()
    end, { noremap = true })
  end,
})
