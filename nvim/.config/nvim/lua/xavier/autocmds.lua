vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    -- Remove highlights off gitsigns
    vim.cmd [[
  hi GitSignsAdd guibg=none
  hi GitSignsChange guibg=none
  hi GitSignsDelete guibg=none
]]
  end,
  group = general,
  desc = 'Disable bg on gitsigns',
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
