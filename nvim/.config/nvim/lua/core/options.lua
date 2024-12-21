-- ~/.config/nvim/lua/core/options.lua
--
local opt = vim.opt

vim.opt.guicursor = ""
-- Core Neovim options and settings

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of word
opt.iskeyword:append("-")

-- Disable swap file
opt.swapfile = false

-- XC
opt.laststatus = 3
opt.scrolloff = 10
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

if vim.fn.has("nvim-0.8") == 1 then
	vim.opt.cmdheight = 0
end

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
-- Option 1: If using bufferline.nvim, add this to your config
vim.opt.showtabline = 0 -- Completely hide the bufferline

-- Option 2: If you're using the default tabline
vim.opt.showtabline = 0 -- This will hide the default tabline

vim.cmd("colorscheme xcnoir")
