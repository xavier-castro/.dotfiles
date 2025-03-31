-- If the current system shell or the `shell` option is set to /usr/bin/fish then revert to sh
if os.getenv("SHELL") == "/usr/bin/fish" or vim.opt.shell == "/usr/bin/fish" then
  vim.opt.shell = "/bin/sh"
else
  -- Else default to the system current shell.
  vim.opt.shell = os.getenv("SHELL")
end

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

vim.g.lazygit_config = true
vim.g.node_host_prog = "$HOME/.bun/bin/neovim-node-host"

opt.laststatus = 3

opt.clipboard = "unnamedplus"

-- Make cursor blink
opt.guicursor = {
  "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50",
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  "sm:block-blinkwait175-blinkoff150-blinkon175",
}
opt.linebreak = true
-- Set tab width
opt.expandtab = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true

-- Disable highlighting if file is over 10 MB
vim.api.nvim_command('autocmd BufReadPost * if getfsize(expand("%:p")) > 10000 * 1024 | TSBufDisable highlight | endif')

vim.cmd([[cab Wq wq]])

-- Disable virtual text
vim.diagnostic.config({ virtual_text = false })

vim.cmd([[tnoremap <C-A-_> pwd\|wl-copy<CR><C-\><C-n>:cd <C-r>+<CR>]])

vim.loader.enable()
-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
