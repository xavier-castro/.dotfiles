-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Lazyvim
vim.g.lazygit_config = true

vim.wo.number = false
vim.wo.relativenumber = false
vim.opt.shell = "fish"

-- Disable highlighting if file is over 10 MB
vim.api.nvim_command('autocmd BufReadPost * if getfsize(expand("%:p")) > 10000 * 1024 | TSBufDisable highlight | endif')

vim.cmd([[cab Wq wq]])

-- Disable virtual text
vim.diagnostic.config({ virtual_text = false })

vim.cmd([[tnoremap <C-A-_> pwd\|wl-copy<CR><C-\><C-n>:cd <C-r>+<CR>]])

vim.loader.enable()

-- Make cursor blink
vim.opt.guicursor = {
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
