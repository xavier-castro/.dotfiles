-- [[ Setting options ]]
-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

local opt = vim.opt
local o = vim.o
local g = vim.g

-- Make line numbers default
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- Relative line numbers for easier navigation
opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- Sync clipboard between OS and Neovim
-- Schedule the setting after `UiEnter` because it can increase startup-time
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeout = true
opt.timeoutlen = 400

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true
opt.cursorlineopt = "number"

-- Minimal number of screen lines to keep above and below the cursor
opt.scrolloff = 10

-- NvChad-specific options
opt.laststatus = 3 -- Global statusline

-- Indenting (NvChad defaults)
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

-- Fill chars
opt.fillchars = { eob = " " }

-- Disable nvim intro
opt.shortmess:append("sI")

-- Go to previous/next line with h,l,left arrow and right arrow
opt.whichwrap:append("<>[]hl")

-- Disable some default providers (performance)
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Add binaries installed by mason.nvim to path
local is_windows = vim.fn.has("win32") ~= 0
local sep = is_windows and "\\" or "/"
local delim = is_windows and ";" or ":"
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, sep) .. delim .. vim.env.PATH