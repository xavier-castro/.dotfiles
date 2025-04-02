local augroup = vim.api.nvim_create_augroup
local XavierGroup = augroup("Xavier", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

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

autocmd({ "BufWritePre" }, {
	group = XavierGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- https://www.reddit.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method("textDocument/foldingRange") then
			local win = vim.api.nvim_get_current_win()
			vim.wo[win][0].foldmethod = "expr"
			vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
		end
	end,
})
vim.api.nvim_create_autocmd("LspDetach", { command = "setl foldexpr<" })

local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
autocmd({ "User" }, {
	pattern = "CodeCompanionInline*",
	group = group,
	callback = function(request)
		if request.match == "CodeCompanionInlineFinished" then
			-- Format the buffer after the inline request has completed
			require("conform").format({ bufnr = request.buf })
		end
	end,
})


-- Remember folds on buffer save and load
local fold_group = augroup("RememberFolds", {})

autocmd("BufWinLeave", {
	group = fold_group,
	pattern = "*",
	callback = function()
		vim.cmd("mkview")
	end,
})

autocmd("BufWinEnter", {
	group = fold_group,
	pattern = "*",
	callback = function()
		vim.cmd("silent! loadview")
	end,
})
