local augroup = vim.api.nvim_create_augroup
local XavierGroup = augroup("Xavier", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

-- Highlight Yanks
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- IDK TBH
autocmd({ "BufWritePre" }, {
	group = XavierGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- Remove annoying autocomment
autocmd({ "BufWinEnter" }, {
	callback = function()
		vim.cmd("set formatoptions-=cro")
	end,
})

-- Automatically add LspInlayHints
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "LspAttach_inlayhints",
	callback = function(args)
		if not (args.data and args.data.client_id) then
			return
		end

		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})

-- Remember Folds
autocmd({ "BufWinEnter" }, {
	group = XavierGroup,
	callback = function()
		vim.cmd([[
let g:skipview_files = [
	\ '[EXAMPLE PLUGIN BUFFER]'
	\ ]
function! MakeViewCheck()
	if has('quickfix') && &buftype =~ 'nofile'
		" Buffer is marked as not a file
		return 0
	endif
	if empty(glob(expand('%:p')))
		" File does not exist on disk
		return 0
	endif
	if index(g:skipview_files, expand('%')) >= 0
		" File is in skip list
		return 0
	endif
	return 1
endfunction
augroup vimrcAutoView
	" Autosave & Load Views.
	autocmd BufWritePost,BufLeave,BufWinLeave,WinLeave ?* if MakeViewCheck() | mkview! | endif
	autocmd BufWinEnter,BufWritePost ?* if MakeViewCheck() | normal! zx
	autocmd BufWinEnter,BufWritePost ?* if MakeViewCheck() | silent! loadview | endif
augroup end
]])
	end,
})

-- Make GitSigns Transparent
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		-- Remove highlights off gitsigns
		vim.cmd([[
  hi GitSignsAdd guibg=none
  hi GitSignsChange guibg=none
  hi GitSignsDelete guibg=none
]])
	end,
	group = XavierGroup,
	desc = "Disable bg on gitsigns",
})
