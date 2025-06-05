-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'
vim.o.showmode = false
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- vim: ts=2 sts=2 sw=2 et

local options = {
  ------------------------------
  -- Indention options
  ------------------------------
  expandtab = true, -- convert tabs to spaces
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  smartindent = true, -- make indenting smarter again
  smarttab = true, -- Insert “tabstop” number of spaces when the “tab” key is pressed.
  tabstop = 2, -- insert 2 spaces for a tab
  autoindent = true, -- lines inherit the indentation of previous lines.
  breakindent = true, -- enable break indent

  ------------------------------
  -- Search options
  ------------------------------
  ignorecase = true, -- ignore case in search patterns
  hlsearch = true, -- highlight all matches on previous search pattern
  smartcase = true, -- switch to case sensitve if we use uppercase letters smart case
  incsearch = true, -- incremental search that shows partial matches.
  inccommand = 'split', -- update changes right away

  ------------------------------
  -- Performance options
  ------------------------------
  lazyredraw = false, -- Don’t update screen during macro and script execution
  updatetime = 300, -- faster completion (4000ms default)
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)

  ------------------------------
  -- Text rendering options
  ------------------------------
  scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`
  wrap = true, -- display lines as one long line
  linebreak = true, -- companion to wrap, don't split words
  syntax = 'enable',
  whichwrap = 'bs<>[]hl', -- which "horizontal" keys are allowed to travel to prev/next line
  numberwidth = 4, -- set number column width to 2 {default 4}
  signcolumn = 'yes', -- always show the sign column, otherwise it would shift the text each time
  -- conceallevel = 0, -- so that `` is visible in markdown files
  fileencoding = 'utf-8', -- the encoding written to a file

  ------------------------------
  -- UI options
  ------------------------------
  -- cmdheight = 0, -- more space in the neovim command line for displaying messages
  pumheight = 10, -- pop up menu height
  showtabline = 0, -- always show tabs
  mouse = 'a', -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  title = false, -- the file currently being edited
  showmode = false, -- we don't need to see mode, we have statusline
  termguicolors = true, -- set term gui colors (most terminals support this)
  laststatus = 3, -- when to have a status line (options from 0-3) 2 default
  showmatch = true, -- Show matching brackets when text indicator is over them
  mat = 2, -- How many tenths of a second to blink when matching brackets
  cursorline = true, -- highlight the current line

  ------------------------------
  -- Split options
  ------------------------------
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window

  ------------------------------
  -- Miscellaneous options
  ----------------------------
  swapfile = false, -- creates a swapfile
  undofile = true, -- enable persistent undo
  -- undodir=$HOME/.local/state/nvim/undo
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  spell = false,

  ------------------------------
  -- Fold text
  ----------------------------
  foldlevel = 99,
  foldexpr = 'v:lua.vim.treesitter.foldexpr()',
  foldmethod = 'expr',
  foldenable = true,
  fillchars = {
    foldopen = '',
    foldclose = '',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    msgsep = '─',
    eob = ' ',
  },
  foldtext = '',

  ------------------------------
  -- Other options
  ------------------------------
  backup = false, -- creates a backup file
  -- clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  completeopt = 'menu,menuone,noselect', -- mostly just for cmp
}

vim.opt.wildignore:append { '*/node_modules/*' }
vim.g.clipboard = 'osc52'
vim.o.winborder = 'rounded'

for k, v in pairs(options) do
  vim.opt[k] = v
end
