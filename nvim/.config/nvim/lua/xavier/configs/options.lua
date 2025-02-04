vim.opt.shiftwidth = 4
vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('v', '<space>x', ':lua<CR>')

vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
-- vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.shiftwidth = 4
vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set('n', '<space><space>x', '<cmd>source %<CR>')
vim.keymap.set('n', '<space>x', ':.lua<CR>')
vim.keymap.set('v', '<space>x', ':lua<CR>')

vim.keymap.set('n', '<M-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-k>', '<cmd>cprev<CR>')

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
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

vim.opt.guicursor = ''

vim.opt.nu = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Wrapped lines are indented to match
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default (for consistent layout)
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- The minimal number of columns to keep to the left and to the right of the cursor if 'nowrap' is set
vim.opt.sidescrolloff = 8

vim.opt.cmdheight = 0

vim.opt.shortmess:append {
  -- l = true, -- use "999L, 888B" instead of "999 lines, 888 bytes"
  -- m = true, -- use "[+]" instead of "[Modified]"
  -- r = true, -- use "[RO]" instead of "[readonly]"
  -- w = true, -- use "[w]" instead of "written" and "[a]" instead of "appended"
  a = true, -- all of the above abbreviations
  o = true, -- overwrite message for writing a file with subsequent message for reading a file
  O = true, -- message for reading a file overwrites any previous message
  s = true, -- don't give "search hit BOTTOM, continuing at TOP" etc.
  t = true, -- truncate file message at the start if it is too long to fit on the command-line
  T = true, -- truncate other messages in the middle if they are too to fit on the command line
  W = true, -- don't give "written" or "[w]" when writing a file
  A = false, -- don't give the "ATTENTION" message when an existing swap file is found
  I = false, -- don't give the intro message when starting Vim
  c = false, -- don't give ins-completion-menu messages
  C = true, -- don't give messages while scanning for ins-completion items
  q = true, -- do not show "recording @a" when recording a macro
  F = true, -- don't give the file info when editing a file
  S = true, -- do not show search count message when searching, e.g. "[1/5]"
}

-- Netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
