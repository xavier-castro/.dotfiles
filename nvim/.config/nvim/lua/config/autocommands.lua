-- Disable line numbers by default
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

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

vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

local job_id = 0
vim.keymap.set('n', '<space>to', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd 'J'
  vim.api.nvim_win_set_height(0, 5)

  job_id = vim.bo.channel
end)

local current_command = ''
vim.keymap.set('n', '<space>te', function()
  current_command = vim.fn.input 'Command: '
end)

vim.keymap.set('n', '<space>tr', function()
  if current_command == '' then
    current_command = vim.fn.input 'Command: '
  end

  vim.fn.chansend(job_id, { current_command .. '\r\n' })
end)

vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('v', '<space>x', ':lua<CR>')
vim.keymap.set('n', '-', '<cmd>Oil --float<CR>')
