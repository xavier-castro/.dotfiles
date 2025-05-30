local autocmd = vim.api.nvim_create_autocmd
local usercmd = vim.api.nvim_create_user_command
local lopt = vim.opt_local

-- Auto change directory to project root or file directory
autocmd({ 'BufEnter' }, {
  pattern = '*',
  callback = function(args)
    local disabled_filetypes = { 'terminal', 'Jaq', 'dashboard', 'gitcommit', 'man', 'help', 'checkhealth' }
    local disabled_buftypes = { 'nofile' }
    if vim.tbl_contains(disabled_filetypes, vim.bo.filetype) or vim.tbl_contains(disabled_buftypes, vim.bo.buftype) then
      return
    end
    local dir = vim.fn.expand '%:p:h'
    local root = vim.fs.root(args.buf, { '.git', 'Makefile', 'Cargo.toml' })
    if root then
      dir = root
    end
    vim.fn.chdir(dir)
  end,
})

autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank { higroup = 'Visual', timeout = 150 }
  end,
})

autocmd({ 'FileType' }, {
  pattern = { 'qf', 'help', 'Jaq', 'man' },
  callback = function()
    vim.keymap.set('n', 'q', '<Cmd>close!<CR>', { silent = true, buffer = true })
    vim.api.nvim_set_option_value('buflisted', false, { buf = 0 })
  end,
})

autocmd('FileType', {
  pattern = { 'lua' },
  command = 'setlocal tabstop=2 shiftwidth=2',
})

autocmd({ 'FileType' }, {
  pattern = { 'python' },
  callback = function()
    lopt.listchars = { multispace = '---+', tab = '> ' }
    lopt.list = true
  end,
})

autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'markdown', 'text', 'man' },
  callback = function()
    lopt.wrap = true
    lopt.spell = true
    lopt.textwidth = 120
  end,
})

usercmd('Grep', function(opts)
  local command = string.format('silent cgetexpr system("rg --vimgrep -S %s")', opts.args)
  vim.cmd(command)
  vim.cmd 'copen'
end, { nargs = 1 })

autocmd('BufWritePre', {
  pattern = '*',
  desc = 'Create parent directories of a file, if they dont exist',
  callback = function()
    local fpath = vim.fn.expand '<afile>'
    local dir = vim.fn.fnamemodify(fpath, ':p:h')

    if vim.fn.isdirectory(dir) ~= 1 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

autocmd('FileType', {
  desc = 'Disable indentscope for certain filetypes',
  pattern = {
    'dashboard',
    'help',
    'leetcode.nvim',
    'man',
    'mason',
    'notify',
    'terminal',
    'toggleterm',
    'trouble',
  },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

-- Show errors and warnings in a floating window
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false, source = 'if_many' })
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('KickstartYankHighlight', { clear = true }),
  pattern = '*',
  callback = function()
    vim.hl.on_yank { timeout = 300 }
  end,
  desc = 'Highlight yanked text',
})

-- Switch to insert mode when terminal is open
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
  -- TermOpen: for when terminal is opened for the first time
  -- BufEnter: when you navigate to an existing terminal buffer
  group = vim.api.nvim_create_augroup('KickstartTerminal', { clear = true }),
  pattern = 'term://*', --> only applicable for "BufEnter", an ignored Lua table key when evaluating TermOpen
  callback = function()
    vim.cmd 'startinsert'
  end,
})

-- Update indentation guide dynamically
local update_leadmultispace_group = vim.api.nvim_create_augroup('UpdateLeadmultispace', { clear = true })

--- Dynamically adjust `leadmultispace` in `listchars` (buffer level) based on `shiftwidth`
local function update_leadmultispace()
  local lead = '┊'
  for _ = 1, vim.bo.shiftwidth - 1 do
    lead = lead .. ' '
  end
  vim.opt_local.listchars:append { leadmultispace = lead }
end

-- When `shiftwidth` was manually changed
vim.api.nvim_create_autocmd('OptionSet', {
  group = update_leadmultispace_group,
  pattern = { 'shiftwidth', 'filetype' },
  callback = update_leadmultispace,
})

-- When shiftwidth was changed by ftplugin
vim.api.nvim_create_autocmd('BufEnter', {
  group = update_leadmultispace_group,
  pattern = '*',
  callback = update_leadmultispace,
  once = true,
})

-- Save and restore folds
local save_fold = vim.api.nvim_create_augroup('save_fold', {})

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*.*',
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})

vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*.*',
  callback = function()
    vim.cmd.loadview { mods = { emsg_silent = true } }
  end,
  group = save_fold,
})

