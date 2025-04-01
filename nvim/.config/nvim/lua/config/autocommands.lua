local augroup = vim.api.nvim_create_augroup
local XavierGroup = augroup("Xavier", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

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

autocmd("BufEnter", {
	group = XavierGroup,
	callback = function()
		if vim.bo.filetype == "zig" then
			vim.cmd.colorscheme("tokyonight-night")
		else
			vim.cmd.colorscheme("tokyonight")
		end
	end,
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

-- autocmd('LspAttach', {
--     group = XavierGroup,
--     callback = function(e)
--         local opts = { buffer = e.buf }
--         vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--         vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--         vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--         vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--         vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
--         vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--         vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--         vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--         vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--         vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--     end
-- })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
