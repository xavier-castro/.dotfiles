local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Declare a global function to retrieve the current directory

local xavierGroup = augroup('xavier', { clear = true })

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

-- Go to the last cursor position when reopening buffer
autocmd('BufReadPost', {
  group = xavierGroup,
  desc = 'Restore last cursor position',
  callback = function()
    vim.defer_fn(function()
      if vim.fn.line '\'"' > 1 and vim.fn.line '\'"' <= vim.fn.line '$' then
        vim.cmd 'normal! g`"'
      end
    end, 0)
  end,
})

-- Enable fenced code highlighting for markdown
vim.g.markdown_fenced_languages = { 'html', 'javascript', 'typescript', 'vim', 'lua', 'css' }

-- Clear NeoCodeium suggestions when CMP menu opens
autocmd('User', {
  group = xavierGroup,
  pattern = 'BlinkCmpMenuOpen',
  desc = 'Clear NeoCodeium when CMP menu opens',
  callback = function()
    local ok, neocodeium = pcall(require, 'neocodeium')
    if ok then
      neocodeium.clear()
    end
  end,
})

-- Disable auto-commenting on newline
autocmd('FileType', {
  pattern = '*',
  group = xavierGroup,
  desc = 'Disable auto comment on new lines',
  callback = function()
    vim.opt.formatoptions:remove { 'c', 'r', 'o' }
  end,
})
