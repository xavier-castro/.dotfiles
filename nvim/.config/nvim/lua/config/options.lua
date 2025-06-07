-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.shell = "fish"
vim.g.lazyvim_blink_main = true
vim.g.lazyvim_eslint_auto_format = false
vim.g.lazyvim_prettier_needs_config = true
vim.g.lazyvim_picker = "telescope"
vim.g.snacks_animate = false

vim.opt.guicursor = ""
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
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
end

-- File types
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

-- Minimal diagnostics configuration
vim.diagnostic.config({
  signs = false, -- Disable sign column icons
  virtual_text = {
    spacing = 4,
    prefix = "●", -- Simple dot instead of icons
    severity = { min = vim.diagnostic.severity.WARN }, -- Only show warnings and errors
  },
  float = {
    border = "rounded",
    source = "if_many", -- Only show source if multiple sources
    header = "",
    prefix = "",
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
