vim.cmd("autocmd!")

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
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.shell = "fish"
vim.opt.cursorline = true

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd([[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
    augroup END
]])

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function()
		vim.cmd([[
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END
]])
	end,
})
-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- Autocommands
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = {
		"Jaq",
		"qf",
		"help",
		"man",
		"lspinfo",
		"Fugitive",
		"fugitive",
		"lir",
		"DressingSelect",
		"tsplayground",
		"Markdown",
		"Neogit",
		"Trouble",
		"trouble",
		"SymbolsOutline",
	},
	callback = function()
		vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted
    ]])
	end,
})

-- Save folds
vim.cmd([[
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview 1
  au BufWinEnter ?* silent! loadview 1
augroup END
]])

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end
