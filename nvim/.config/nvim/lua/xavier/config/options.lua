vim.opt.guicursor = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

-- Autocommands
-- Make GitSigns transparent background
vim.cmd([[
  augroup GitSignsHighlights
    autocmd!
    autocmd ColorScheme * highlight GitSignsAdd guibg=NONE
    autocmd ColorScheme * highlight GitSignsChange guibg=NONE
    autocmd ColorScheme * highlight GitSignsDelete guibg=NONE
  augroup END
]])

-- Make Neovim remember folds
vim.cmd([[
augroup RememberFolds
    autocmd!
    au BufWinLeave ?* mkview 1
    au BufWinEnter ?* silent! loadview 1
augroup END
]])
