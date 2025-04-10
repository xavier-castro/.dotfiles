require 'xavier.set'
require 'xavier.remap'
require 'xavier.lazy_init'

local augroup = vim.api.nvim_create_augroup
local XavierGroup = augroup('xavier', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
  require('plenary.reload').reload_module(name)
end

vim.filetype.add {
  extension = {
    templ = 'templ',
  },
}

autocmd('TextYankPost', {
  group = yank_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

autocmd({ 'BufWritePre' }, {
  group = XavierGroup,
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

autocmd('BufEnter', {
  group = XavierGroup,
  callback = function()
    if vim.bo.filetype == 'zig' then
      vim.cmd.colorscheme 'tokyonight-night'
    else
      vim.cmd.colorscheme 'rose-pine-moon'
    end
  end,
})

autocmd('LspAttach', {
  group = XavierGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opts)
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', opts)
    vim.keymap.set('n', '<leader>ol', '<cmd>Lspsaga outline<cr>', opts)
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_dock<cr>', opts)
    vim.keymap.set('n', '<leader>ca', '<cmd>Lspsaga code_action<cr>', opts)
    vim.keymap.set('n', '<leader>crn', '<cmd>Lspsaga rename<Cr>', opts)
    vim.keymap.set('n', '[d', function()
      require('lspsaga.diagnostic'):goto_prev()
    end, { desc = 'Previous diagnostic' })

    vim.keymap.set('n', ']d', function()
      require('lspsaga.diagnostic'):goto_next()
    end, { desc = 'Next diagnostic' })

    vim.keymap.set('n', '[e', function()
      require('lspsaga.diagnostic'):goto_prev { severity = vim.diagnostic.severity.ERROR }
    end, { desc = 'Previous error' })

    vim.keymap.set('n', ']e', function()
      require('lspsaga.diagnostic'):goto_next { severity = vim.diagnostic.severity.ERROR }
    end, { desc = 'Next error' })
  end,
})

vim.diagnostic.config {
  virtual_text = false,
  virtual_lines = { current_line = true },
  underline = true,
  update_in_insert = false,
}

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
